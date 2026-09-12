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
@@||media-renew.top^$important
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
@@||spectrum.net^$important
@@||att.com^$important
@@||t-mobile.com^$important
@@||clover.com^$important
@@||parpos.com^$important
@@||adp.com^$important
@@||olo.com^$important
@@||fdcnet.biz^$important
@@||firstdata.com^$important
@@||fisglobal.com^$important
@@||brinkpos.net^$important
@@||partech.com^$important
@@||wgiftcard.com^$important
@@||pinkberry.com^$important
@@||kahalamgmt.com^$important
@@||mtygroup.com^$important
@@||tech4dteam.com^$important
@@||americanexpress.com^$important
@@||amexnetwork.com^$important
@@||bankofamerica.com^$important
@@||bofa.com^$important
@@||wellsfargo.com^$important
@@||chase.com^$important
@@||jpmorganchase.com^$important
@@||capitalone.com^$important
@@||citibank.com^$important
@@||citi.com^$important
@@||usbank.com^$important
@@||pnc.com^$important
@@||truist.com^$important
@@||discover.com^$important
@@||synchrony.com^$important
@@||navyfederal.org^$important
@@||regions.com^$important
@@||ally.com^$important
@@||visa.com^$important
@@||mastercard.com^$important
@@||americanexpress.com^$important
@@||discover.com^$important
@@||fisglobal.com^$important
@@||firstdata.com^$important
@@||globalpaymentsinc.com^$important
@@||worldpay.com^$important
@@||punchh.com^$important
@@||turkishairlines.com^$important
@@||qatarairways.com^$important
@@||emirates.com^$important
@@||lufthansa.com^$important
@@||britishairways.com^$important
@@||airfrance.com^$important
@@||klm.com^$important
@@||americanairlines.com^$important
@@||united.com^$important
@@||delta.com^$important
@@||flydubai.com^$important
@@||pegasus.com^$important
@@||etihad.com^$important
@@||sahibinden.com^$important
@@||shbd.io^$important
EOF

# ===== final =====
cat whitelist.txt merged_clean.txt > final.txt

mv final.txt merged.txt

# ===== clean =====
rm raw.txt cleaned.txt merged_clean.txt whitelist.txt
