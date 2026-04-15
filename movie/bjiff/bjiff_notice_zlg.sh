#!/bin/bash

curl 'https://mt-m.maoyan.com/api/mtrade/@theatreShow/getShowByCinema?yodaReady=h5&csecplatform=4&csecversion=4.2.0&mtgsig=%7B%22a1%22%3A%221.2%22%2C%22a2%22%3A1776187753166%2C%22a3%22%3A%22w5wxx607yy3754x110919v3v254xxy2x80w2w3vxz13979580w713119%22%2C%22a5%22%3A%22s1CqUYwflpRMdUXpZrQhu94ppdwfu9JLEvRNsXV695u%2BwT82Ur7221Bc5SFghekOE5loomHMZOUKsDt5qcWkkSTu%22%2C%22a6%22%3A%22hs1.68rZW92gC65R6o6QZVJyMm573dsSwuY4FfpIArmvYFPayCeVpvLuLCguRU9mtfqXV15pi21lBh5OPoDL7%2BmdVof7H4GRren%2BYuJuWTPVfcx5Jtwv3JfSPedCcob%2F8QLj%2B%22%2C%22a8%22%3A%22f087a1589b61ddb34f4eeab53b407937%22%2C%22a9%22%3A%224.2.0%2C7%2C216%22%2C%22a10%22%3A%22be%22%2C%22x0%22%3A4%2C%22d1%22%3A%22b80f4eaf5b1bdf4eaebacb5fe31491e6%22%7D' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -b 'from=canary; webp=true; iuuid=BC29C70035C511F196D3F14091B015EAF4C1E32EB7DF4BEDBD92B133F0F3E684; uuid=BC29C70035C511F196D3F14091B015EAF4C1E32EB7DF4BEDBD92B133F0F3E684; _lxsdk_cuid=19d7d6e6fc2c8-07cc4fbc0f6fab8-26061a51-144000-19d7d6e6fc2c8; _tea_utm_cache_586864={%22utm_source%22:%22maoyan_appShare%22}; WEBDFPID=w5wxx607yy3754x110919v3v254xxy2x80w2w3vxz13979580w713119-1776012305778-1775925881076ICWSUCYfd79fef3d01d5e9aadc18ccd4d0c95073093; utm_source_rg=AM%257eXHDHi%25276%25B7BIIRZg..Ag7FIqqZNqNeAeL7FII.LIOZBLBAeI1qANgN7OZBgqAqqN; token=AgHWJf1j-0mgIJsBYsQpg7O9LKb9X4h7GnWyj2M6_G7bkLyPDGRNl-cB273BwwptnuN5ZTAU-x-91AAAAAAENAAATq6Mi6FxhTzV8akKa62xbXXzz2HX2GNtX2SyYJbn5Ga8_PgFaTEbdzkI_O-Kyaqe; uid=92613216; ff-user=92613216,AgHWJf1j-0mgIJsBYsQpg7O9LKb9X4h7GnWyj2M6_G7bkLyPDGRNl-cB273BwwptnuN5ZTAU-x-91AAAAAAENAAATq6Mi6FxhTzV8akKa62xbXXzz2HX2GNtX2SyYJbn5Ga8_PgFaTEbdzkI_O-Kyaqe; _lxsdk=BC29C70035C511F196D3F14091B015EAF4C1E32EB7DF4BEDBD92B133F0F3E684; logan_session_token=nm4xe47k8lg1py6xttng; _lx_utm=utm_source%3Dmaoyan_appShare; user=92613216%2CAgHWJf1j-0mgIJsBYsQpg7O9LKb9X4h7GnWyj2M6_G7bkLyPDGRNl-cB273BwwptnuN5ZTAU-x-91AAAAAAENAAATq6Mi6FxhTzV8akKa62xbXXzz2HX2GNtX2SyYJbn5Ga8_PgFaTEbdzkI_O-Kyaqe; _lxsdk_s=19d8d086656-f7d-fa3-36a%7C92613216%7C43' \
  -H 'DNT: 1' \
  -H 'Origin: https://mt-m.maoyan.com' \
  -H 'Referer: https://mt-m.maoyan.com/mtrade/filmfest/schedule/cinema-list?cinemaId=2010&theatreId=BJIFF16th&from=canary' \
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
  --data-raw '{"theatreId":120,"cinemaId":2010}' > cinema_zlg.json

# "showSaleStatus": 1  未售罄
# "showSaleStatus": 2  已售罄

# 血色将至
# 423 罗斯
for showId in 20260417834 20260426288 20260423437
do
	flag=$(cat cinema_zlg.json |jq --arg target "${showId}" -r '.data|.data[]|.showList|.[]|select(.showId == $target)|.showSaleStatus')
	
	if [[ $flag == 1 ]];then
	    echo "showId ${showId}" | mail -s "showId ${showId}" 1031138448@qq.com &>/dev/null
	fi
done
