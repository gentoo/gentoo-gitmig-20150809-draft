# this makefile is for building out-of-tree

CFLAGS+=-DCONFIG_IEEE80211_SOFTMAC_DEBUG=1
CFLAGS+=-DIEEE80211_DEBUG=1

KDIR ?= /lib/modules/`uname -r`/build
MODPATH ?= /lib/modules/`uname -r`/kernel/net/ieee80211
modules:
	make -C $(KDIR) SUBDIRS=`pwd`/net/ieee80211 CONFIG_IEEE80211=m CONFIG_IEEE80211_CRYPT_WEP=m CONFIG_IEEE80211_CRYPT_CCMP=m CONFIG_IEEE80211_CRYPT_TKIP=m CC="${CROSS_COMPILE}gcc -I`pwd`/include" modules
	make -C $(KDIR) SUBDIRS=`pwd`/net/ieee80211/softmac CONFIG_IEEE80211_SOFTMAC=m CC="${CROSS_COMPILE}gcc -I`pwd`/include" modules

install: modules
	install -d /lib/modules/`uname -r`/kernel/net/ieee80211
	install -m 644 -c `pwd`/net/ieee80211/ieee80211.ko $(MODPATH)
	install -m 644 -c `pwd`/net/ieee80211/ieee80211_crypt.ko $(MODPATH)
	install -m 644 -c `pwd`/net/ieee80211/ieee80211_crypt_ccmp.ko $(MODPATH)
	install -m 644 -c `pwd`/net/ieee80211/ieee80211_crypt_tkip.ko $(MODPATH)
	install -m 644 -c `pwd`/net/ieee80211/ieee80211_crypt_wep.ko $(MODPATH)
	install -d $(MODPATH)/softmac
	install -m 644 -c `pwd`/net/ieee80211/softmac/ieee80211softmac.ko /lib/modules/`uname -r`/kernel/net/ieee80211/softmac
	install -d $(KDIR)/include/net
	install -m 644 -c `pwd`/include/net/ieee80211.h $(KDIR)/include/net
	install -m 644 -c `pwd`/include/net/ieee80211_crypt.h $(KDIR)/include/net
	install -m 644 -c `pwd`/include/net/ieee80211_radiotap.h $(KDIR)/include/net
	install -m 644 -c `pwd`/include/net/ieee80211softmac.h $(KDIR)/include/net
	install -m 644 -c `pwd`/include/net/ieee80211softmac_wx.h $(KDIR)/include/net
	/sbin/depmod -a

uninstall:
	rm -rf $(MODPATH)
	rm -f $(KDIR)/include/net/ieee80211.h
	rm -f $(KDIR)/include/net/ieee80211_crypt.h
	rm -f $(KDIR)/include/net/ieee80211_radiotap.h
	rm -f $(KDIR)/include/net/ieee80211softmac.h
	rm -f $(KDIR)/include/net/ieee80211softmac_wx.h
	/sbin/depmod -a

clean:
	find . \( -name '*.ko' -o -name '*.o' -o -name '.tmp_versions' -o -name '*~' -o -name '.*.cmd' \
		-o -name '*.mod.c' -o -name '*.tar.bz2' -o -name '*.rej' -o -name '*.orig' \)\
		-print | xargs rm -Rf
