❯ sudo trust anchor --store steamcommunity.crt
❯ certutil -D -d sql:/home/ldsr/.pki/nssdb -n "Steamcommunity302" > /dev/null 2>&1
certutil -A -d sql:/home/ldsr/.pki/nssdb -n "Steamcommunity302" -t C,, -i "/home/ldsr/Steamcommunity_302/steamcommunityCA.pem"
