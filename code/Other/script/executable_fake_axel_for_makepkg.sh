#!/bin/bash

domin=$(echo "$2" | cut -f3 -d'/')
others=$(echo "$2" | cut -f4- -d'/')

case "$domin" in
    "github.com" | "raw.githubusercontent.com")
        if [[ "$domin" == "github.com" ]]; then
            mirrors=(
                # "https://gitclone.com/%s"
                "https://kkgithub.com/%s"
                # "https://wget.la/https://github.com/%s"
                "https://ghfast.top/https://github.com/%s"
                "https://githubfast.com/%s"
                "https://ghproxy.net/https://github.com/%s"
            )
        else
            mirrors=(
                "https://ghproxy.net/https://raw.githubusercontent.com/%s"
                "https://ghfast.top/https://raw.githubusercontent.com/%s"
                # "https://githubfast.com/https://raw.githubusercontent.com/%s"
                "https://api.metr.cc/https://raw.githubusercontent.com/%s"
            )
        fi
        path="$others"
        fastest_url=""
        min_time=99999

        for mirror_format in "${mirrors[@]}"; do
            mirror_url=$(printf "$mirror_format" "$path")
            echo -n "Testing $mirror_url ..."
            
            # 使用GET请求测试（下载前1字节验证有效性）
            response=$(curl -L -s -o /dev/null \
                     --connect-timeout 5 \
                     --max-time 10 \
                     -k \
                     -w '%{http_code} %{time_total} %{size_download}' \
                     -H 'User-Agent: Mozilla/5.0' \
                     --range 0-0 \
                     "$mirror_url" 2>/dev/null)
            
            http_code=$(echo "$response" | awk '{print $1}')
            time=$(echo "$response" | awk '{print $2}')
            downloaded_size=$(echo "$response" | awk '{print $3}')

            # 显示状态码和响应时间
            echo -n " [HTTP:$http_code]"
            [[ -n "$time" ]] && echo " [TIME:${time}s]" || echo " [TIMEOUT]"

            # 增强有效性检查：状态码200/206 + 实际下载字节 > 0
            if [[ "$http_code" =~ ^(200|206)$ && -n "$time" && "$downloaded_size" -gt 0 ]]; then
                if (( $(echo "$time < $min_time" | bc -l) )); then
                    min_time=$time
                    fastest_url="$mirror_url"
                fi
            fi
        done

        if [ -n "$fastest_url" ]; then
            url="$fastest_url"
            echo "Selected fastest mirror: $url (Time: $min_time seconds)"
        else
            url="$2"
            echo "WARNING: All mirrors failed, falling back to original URL"
        fi
        ;;
    *)
        url="$2"
        ;;
esac

echo "Downloading from $url"
/usr/bin/axel -n 10 -a -o "$1" "$url" || {
    echo "ERROR: Axel download failed, trying fallback to curl..."
    curl -# -L -k -o "$1" "$url"
}