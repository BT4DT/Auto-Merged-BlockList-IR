#!/bin/bash

rm -f merged.txt raw.txt clean.txt whitelist.txt final.txt

# ===== list =====
urls=(
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlocker-Deprecated.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlocker.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAds-Domains.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAds-Hosts.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAds.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAnnoyances-Domains.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAnnoyances.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerCensor-Domains.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerCensor.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerHalfPrice.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerHosts.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerMalware.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerMobile.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerPhishing.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerSMS.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerTrackers-Domains.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerTrackers-Hosts.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerTrackers.txt"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/hosts"
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/hosts-0"
"https://adguardteam.github.io/HostlistsRegistry/assets/filter_19.txt"
)

for url in "${urls[@]}"; do
  curl -sL "$url" >> raw.txt
done

# ===== extract domain =====
grep -Eo '([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}' raw.txt > clean.txt

# ===== Del junk =====
grep -vE 'localhost|localdomain|broadcasthost' clean.txt > tmp.txt

# ===== convert adblock =====
sed 's/^/||/' tmp.txt | sed 's/$/^/' > merged.txt

# ===== Del duplicate =====
sort -u merged.txt > merged_clean.txt

# ===== Make whitelist =====
cat <<EOF > whitelist.txt
@@||gstatic.com^
@@||digikala.com^
@@||snapp.ir^
@@||soft98.ir^
@@||snappfood.ir^
@@||cafebazaar.ir^
@@||divar.ir^
@@||sheypoor.com^
@@||aparat.com^
@@||namava.ir^
@@||filimo.com^
@@||irancell.ir^
@@||mci.ir^
@@||soft98.ir^
@@||shaparak.ir^
@@||zarinpal.com^
@@||dnsforge.de^
@@||mymax.top^
@@||plusiptv.dnsz.in^
@@||plusiptv.tvdns.top^
@@||plusiptv.dnsset.site^
@@||alibaba.ir^
@@||idpay.ir^
EOF

# ===== Final =====
cat whitelist.txt merged_clean.txt > final.txt

# ===== Export =====
mv final.txt merged.txt

# ===== Clean =====
rm raw.txt clean.txt tmp.txt merged_clean.txt whitelist.txt
