# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.5_pre20041110.ebuild,v 1.1 2004/11/22 20:05:39 mrness Exp $

inherit eutils

MY_PV="${PV/*_pre/}"
MY_P="${PN}-CVS-${MY_PV:0:4}-${MY_PV:4:2}-${MY_PV:6:2}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="ISDN4Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/CVS-Snapshots/${MY_P}.tar.bz2"
HOMEPAGE="http://www.isdn4linux.de/"

KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE="X unicode"
SLOT="0"

RDEPEND="virtual/modutils
	virtual/libc
	sys-libs/ncurses
	sys-libs/gdbm
	dev-lang/tcl
	X? ( virtual/x11 )"

DEPEND="${RDEPEND}
	virtual/linux-sources"

src_setup() {
	# Get country code from I4L_CC variable
	# default country: DE (Germany)
	I4L_CC=$(echo -n "${I4L_CC}" | tr "[:lower:]" "[:upper:]")
	[ -z "${I4L_CC}" ] && I4L_CC="DE"
	I4L_CC_LOW=$(echo -n "${I4L_CC}" | tr "[:upper:]" "[:lower:]")

	# Get language from I4L_LANG variable ('de' or 'en')
	I4L_LANG=$(echo -n "${I4L_CC}" | tr "[:lower:]" "[:upper:]")
	if [ -z "${I4L_LANG}" ]; then
		case "${I4L_CC}" in
			AT|CH|DE)
				I4L_LANG="DE"
				;;
			*)
				I4L_LANG="EN"
				;;
		esac
	fi
	[ "${I4L_LANG}" = "DE" -o "${I4L_LANG}" = "EN" ] || I4L_LANG="EN"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix for 2.6 headers
	find . -name "*.c" | \
	xargs -r sed -i -e 's:linux/capi.h>$:linux/compiler.h>\n#include <linux/capi.h>:g'

	# patch all Makefiles to use our CFLAGS
	find . -name "Makefile*" | \
	xargs -r sed -i -e "s:^CFLAGS\(.*\)-O[26]:CFLAGS\1${CFLAGS}:g" \
					-e "s:^CFLAGS\(.*\)-g:CFLAGS\1${CFLAGS}:g" \
					-e "s:^CFLAGS = -Wall$:CFLAGS = ${CFLAGS}:g" || die "sed failed"

	# install our config
	case "${I4L_CC}" in
		DE|AT|NL|LU|CH)
			# These countries are specially supported in the isdnlog source.
			sed -e "s:^CONFIG_ISDN_LOG_XX=:CONFIG_ISDN_LOG_${I4L_CC}=:g" -e "s:^CONFIG_ISDN_LOG_CC=.*$:#:g" \
				-e "s:^\(CONFIG_ISDN_LOG_CC_\)..=:\1${I4L_LANG}=:g" < ${FILESDIR}/${PV}/config > .config || die "failed to modify .config"
			;;
		*)
			# Others get a generic isdnlog.
			sed -e "s:^\(CONFIG_ISDN_LOG_CC=\).*$:\1'${I4L_CC_LOW}':g" \
				-e "s:^\(CONFIG_ISDN_LOG_CC_\)..=:\1${I4L_LANG}=:g" < ${FILESDIR}/${PV}/config > .config || die "failed to modify .config"
			;;
	esac

	useq X || \
		sed -i -e "s:^CONFIG_BUILDX11=.*$:#:g" \
			-e "s:^CONFIG_XISDNLOAD=.*$:#:g" \
			-e "s:^CONFIG_XMONISDN=.*$:#:g" .config

	# Patch in order to make generic config for countries which are not known to isdnlog source
	sed -i -e "s:\$(INSTALL_DATA) rate-:-\$(INSTALL_DATA) rate-:g" \
		-e "s:\$(INSTALL_DATA) holiday-:-\$(INSTALL_DATA) holiday-:g" isdnlog/Makefile.in

	# if specified, convert all relevant files from latin1 to UTF-8
	if useq unicode; then
		for i in isdnlog/samples/{isdn,rate}.conf* isdnlog/*-{at,ch,de,no}.dat isdnlog/{Isdn,.country-alias}; do
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_compile() {
	make subconfig || die "make subconfig failed"
	make || die "make failed"
}

src_install() {
	keepdir /var/lib/isdn
	dodir /dev /etc/isdn /usr/bin /usr/sbin
	make DESTDIR=${D} install || die "make install failed"

	# remove obsolete firmware files
	rm -f ${D}/usr/share/isdn/{bip1120.btl,dnload.bin,ds4bri.bit,dspdload.bin}
	rm -f ${D}/usr/share/isdn/{loadpg.bin,pc_??_ca.bin,prload.bin,te_????.*}

	# install docs (base)
	dodoc NEWS README Mini-FAQ/isdn-faq.txt scripts/makedev.sh FAQ/_howto/xp*

	# install docs (ipppd)
	docinto ipppd
	dodoc LEGAL.ipppcomp ipppd/{README,README.*.ORIG,NOTES.IPPPD} ipppcomp/README.LZS  # ipppd/README.RADIUS
	docinto ipppd/example
	dodoc FAQ/_example/*.txt
	docinto ipppd/howto
	dodoc FAQ/_howto/{dns*,i4l_ipx*,isdn*,lan*,leased*,masq*,mppp*,ppp*,route*}

	# install docs (isdnlog)
	docinto isdnlog
	dodoc isdnlog/{BUGS,FAQ,Isdn,NEWS,README*} FAQ/_howto/win*
	docinto isdnlog/areacode
	dodoc areacode/*.doc
	docinto isdnlog/contrib/isdnbill
	dodoc isdnlog/contrib/isdnbill/{*.isdnbill,*.gz}
	docinto isdnlog/contrib/winpopup
	dodoc isdnlog/contrib/winpopup/*

	# install docs (eft)
	docinto eft
	dodoc eurofile/{CHANGES,INSTALL,README*,TODO}
	newdoc eurofile/src/wuauth/README README.AUTHLIB
	docinto eft/scripts
	dodoc eurofile/scripts/{eft_useradd,check_system,ix25test,eftd.sh,eftp.sh}

	# install init-scripts
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PV}/isdn.init isdn
	newexe ${FILESDIR}/${PV}/net.ippp0 net.ippp0
	newexe ${FILESDIR}/${PV}/isdnlog.init isdnlog.contr0

	# install init-configs
	insinto /etc/conf.d
	newins ${FILESDIR}/${PV}/isdn.conf isdn
	newins ${FILESDIR}/${PV}/isdnlog.conf isdnlog.contr0

	# install example scripts and configs
	exeinto /etc/ppp
	insinto /etc/ppp
	doexe ${FILESDIR}/${PV}/{ip-up,ip-down}
	doins ${FILESDIR}/${PV}/{ioptions,options.ippp0}

	# install example configs
	insinto /etc/isdn
	doins isdnlog/samples/{isdn,rate}.conf.{at,de,lu,nl,no,pl}
	newins isdnlog/samples/isdn.conf isdn.conf.unknown
	if [ -f isdnlog/samples/isdn.conf.${I4L_CC_LOW} ]; then
		newins isdnlog/samples/isdn.conf.${I4L_CC_LOW} isdn.conf
	else
		doins isdnlog/samples/isdn.conf
	fi
	if [ -f isdnlog/samples/rate.conf.${I4L_CC_LOW} ]; then
		newins isdnlog/samples/rate.conf.${I4L_CC_LOW} rate.conf
	fi
	sed -i -e "s:/usr/lib/isdn/:/usr/share/isdn/:g" ${D}/etc/isdn/isdn.conf*

	# install sample provider script
	exeinto /etc/isdn
	doexe isdnlog/samples/provider

	# rename isdnlog options file
	insinto /etc/isdn
	mv -f ${D}/etc/isdn/isdnlog.isdnctrl0.options ${D}/etc/isdn/isdnlog.options.contr0

	# install isdnlog data files
	insinto /usr/share/isdn
	doins isdnlog/*.dat

	# install logrotate configs
	insinto /etc/logrotate.d
	newins ${FILESDIR}/${PV}/isdnlog.logrotated isdnlog
}

pkg_postinst() {
	einfo
	einfo "Please edit:"
	einfo
	einfo "- /etc/conf.d/isdn   to contain your ISDN kernel modules"
	einfo "- /etc/ppp/*         critical if you need networking"
	einfo
	einfo "For isdnlog you should edit:"
	einfo
	einfo "- /etc/conf.d/isdnlog.contr0"
	einfo "- /etc/isdn/isdnlog.options.contr0"
	einfo "- /etc/isdn/*.conf"
	einfo
	einfo "/etc/init.d/isdn will save and restore your isdnctrl config."
	einfo "it will also handle the modem-register daemon."
	einfo
	einfo "/etc/init.d/net.ippp0 will start synchronous PPP connections"
	einfo "which you need to set up using isdnctrl first!"
	einfo
	einfo "/etc/init.d/isdnlog.contr0 starts and stops isdnlog for contr0"
	einfo "You can symlink it to isdnlog.contr1 and copy the corresponding"
	einfo "configs if you have more than one card."
	einfo
}
