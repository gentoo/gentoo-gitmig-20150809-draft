#!/bin/sh
# $:Id:$

XMODIFIERS=@im=htt ; export XMODIFIERS
HTT_DISABLE_STATUS_WINDOW=t ; export HTT_DISABLE_STATUS_WINDOW
HTT_GENERATES_KANAKEY=t ; export HTT_GENERATES_KANAKEY
HTT_USES_LINUX_XKEYSYM=t ; export HTT_USES_LINUX_XKEYSYM

exec env LC_ALL=ja_JP.eucJP /usr/lib/im/httx \
	-if canna \
	-lc_basic_locale ja_JP.eucJP \
	-xim htt_xbe
