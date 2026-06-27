#!/bin/bash

rm -f raw.txt merged_clean.txt final.txt whitelist.txt

# ===== list =====
urls=(
# =========== IRN
# ===  🟢 Persian -PersianBlocker-Deprecated.txt :: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlocker-Deprecated.txt"
# ===  🟢 Persian -PersianBlockerAds-Domains.txt:: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAds-Domains.txt"
# ===  🟢 Persian -PersianBlockerAds-Hosts.txt:: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAds-Hosts.txt"
# ===  🟢 Persian -PersianBlockerAds.txt:: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAds.txt"
# ===  🟢 Persian -PersianBlockerHosts.txt:: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerHosts.txt"
# =========== END
)

# ===== download =====
for url in "${urls[@]}"; do
  curl -sL "$url" >> raw.txt
  echo -e "\n" >> raw.txt
done

# ===== clean basic =====
grep -vE '^\s*$' raw.txt | \
grep -vE 'localhost|localdomain|broadcasthost' > cleaned.txt

# ===== remove duplicate =====
sort -u cleaned.txt > merged_clean.txt

# ===== whitelist =====
cat <<EOF > whitelist.txt
# ==== WHITELIST ====
# remove # to enable
@@||dnsforge.de^$important
@@||mymax.top^$important
@@||dnsz.in^$important
@@||plusiptv.dnsz.in^$important
@@||tvdns.top^$important
@@||plusiptv.tvdns.top^$important
@@||media-shop.top^$important
@@||filimo.com^$important
@@||namava.ir^$important
@@||filmnet.ir^$important
@@||snapp.site^$important
@@||aptel.ir^$important
@@||soft98.ir^$important
@@||github.com^$important
@@||tailscale.com^$important
@@||zerotier.com^$important
@@||tello.com^$important
@@||usmobile.com^$important
@@||goodcloud.xyz^$important
@@||astrowarp.net^$important
EOF

# ===== final =====
cat whitelist.txt merged_clean.txt > final.txt

mv final.txt merged.txt

# ===== clean =====
rm raw.txt cleaned.txt merged_clean.txt whitelist.txt
