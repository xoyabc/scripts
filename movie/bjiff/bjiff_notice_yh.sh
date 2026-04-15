#!/bin/bash

curl 'https://mt-m.maoyan.com/api/mtrade/@theatreShow/getShowByCinema?yodaReady=h5&csecplatform=4&csecversion=4.2.0&mtgsig=%7B%22a1%22%3A%221.2%22%2C%22a2%22%3A1776190613172%2C%22a3%22%3A%22w5wxx607yy3754x110919v3v254xxy2x80w2w3vxz13979580w713119%22%2C%22a5%22%3A%22D3he6Ol0EHTHNvd9TZz8VtNbGA8NJE2QKUoZvcXq9kGX2zUxLVnTQ%2FvHRWiuk%2BVrLAun6NDiJeS39N9hboKqUkyyHI%3D%3D%22%2C%22a6%22%3A%22hs1.60juVUnDdEjtFup9J34jdGsiDjIoIY%2F27RvBbixmp2lev8dPeWBMIIwQZxt%2FJsFzJjGkB06MucFmwkRPiRiFQicY4N0O3cBHsuLRCUQug3QlsfoLganHkCLIReGDBGWVF%22%2C%22a8%22%3A%22e4f71127d7398f4df8c34a8c41abbfea%22%2C%22a9%22%3A%224.2.0%2C7%2C216%22%2C%22a10%22%3A%22be%22%2C%22x0%22%3A4%2C%22d1%22%3A%223347a8825ba6a493578e411f68e10c02%22%7D' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -b 'from=canary; webp=true; iuuid=BC29C70035C511F196D3F14091B015EAF4C1E32EB7DF4BEDBD92B133F0F3E684; uuid=BC29C70035C511F196D3F14091B015EAF4C1E32EB7DF4BEDBD92B133F0F3E684; _lxsdk_cuid=19d7d6e6fc2c8-07cc4fbc0f6fab8-26061a51-144000-19d7d6e6fc2c8; _tea_utm_cache_586864={%22utm_source%22:%22maoyan_appShare%22}; WEBDFPID=w5wxx607yy3754x110919v3v254xxy2x80w2w3vxz13979580w713119-1776012305778-1775925881076ICWSUCYfd79fef3d01d5e9aadc18ccd4d0c95073093; utm_source_rg=AM%257eXHDHi%25276%25B7BIIRZg..Ag7FIqqZNqNeAeL7FII.LIOZBLBAeI1qANgN7OZBgqAqqN; token=AgHWJf1j-0mgIJsBYsQpg7O9LKb9X4h7GnWyj2M6_G7bkLyPDGRNl-cB273BwwptnuN5ZTAU-x-91AAAAAAENAAATq6Mi6FxhTzV8akKa62xbXXzz2HX2GNtX2SyYJbn5Ga8_PgFaTEbdzkI_O-Kyaqe; uid=92613216; ff-user=92613216,AgHWJf1j-0mgIJsBYsQpg7O9LKb9X4h7GnWyj2M6_G7bkLyPDGRNl-cB273BwwptnuN5ZTAU-x-91AAAAAAENAAATq6Mi6FxhTzV8akKa62xbXXzz2HX2GNtX2SyYJbn5Ga8_PgFaTEbdzkI_O-Kyaqe; _lxsdk=BC29C70035C511F196D3F14091B015EAF4C1E32EB7DF4BEDBD92B133F0F3E684; logan_session_token=nm4xe47k8lg1py6xttng; _lx_utm=utm_source%3Dmaoyan_appShare; user=92613216%2CAgHWJf1j-0mgIJsBYsQpg7O9LKb9X4h7GnWyj2M6_G7bkLyPDGRNl-cB273BwwptnuN5ZTAU-x-91AAAAAAENAAATq6Mi6FxhTzV8akKa62xbXXzz2HX2GNtX2SyYJbn5Ga8_PgFaTEbdzkI_O-Kyaqe; _lxsdk_s=19d8d086656-f7d-fa3-36a%7C92613216%7C178' \
  -H 'DNT: 1' \
  -H 'Origin: https://mt-m.maoyan.com' \
  -H 'Referer: https://mt-m.maoyan.com/mtrade/filmfest/schedule/cinema-list?cinemaId=25274&theatreId=BJIFF16th&from=canary' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36' \
  -H 'X-Channel-ID: 4' \
  -H 'X-Requested-With: ajax' \
  -H 'channelId: 4' \
  -H 'sec-ch-ua: "Google Chrome";v="143", "Chromium";v="143", "Not A(Brand";v="24"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'token: AgHWJf1j-0mgIJsBYsQpg7O9LKb9X4h7GnWyj2M6_G7bkLyPDGRNl-cB273BwwptnuN5ZTAU-x-91AAAAAAENAAATq6Mi6FxhTzV8akKa62xbXXzz2HX2GNtX2SyYJbn5Ga8_PgFaTEbdzkI_O-Kyaqe' \
  -H 'uuid: BC29C70035C511F196D3F14091B015EAF4C1E32EB7DF4BEDBD92B133F0F3E684' \
  -H 'x-csrf-token;' \
  --data-raw '{"theatreId":120,"cinemaId":25274}' > cinema_yh.json

# "showSaleStatus": 1  未售罄
# "showSaleStatus": 2  已售罄

# 旅行
for showId in 202604181191
do
        flag=$(cat cinema_yh.json |jq --arg target "${showId}" -r '.data|.data[]|.showList|.[]|select(.showId == $target)|.showSaleStatus')

        if [[ $flag == 1 ]];then
            echo "showId ${showId}" | mail -s "showId ${showId}" 1031138448@qq.com &>/dev/null
        fi
done
