# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.7_pre20050626.ebuild,v 1.2 2005/07/02 09:34:30 dholm Exp $

inherit eutils linux-info multilib gnuconfig

MY_PV="${PV/*_pre/}"
MY_P="${PN}-CVS-${MY_PV:0:4}-${MY_PV:4:2}-${MY_PV:6:2}"

DESCRIPTION="ISDN4Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/CVS-Snapshots/${MY_P}.tar.bz2"
HOMEPAGE="http://www.isdn4linux.de/"

KEYWORDS="~alpha ~amd64 ~ppc ~x86"
LICENSE="GPL-2"
IUSE="X unicode ipppd isdnlog eurofile"
#IUSE="X unicode ipppd isdnlog eurofile mysql postgres oracle"
SLOT="0"

# mysql? ( dev-db/mysql )
# oracle? ( dev-db/oracle-instantclient-basic )
# postgres? ( dev-db/postgresql )

DEPEND="virtual/linux-sources
	virtual/libc
	sys-libs/ncurses
	sys-libs/gdbm
	dev-lang/tcl
	X? ( virtual/x11 )"
RDEPEND="${DEPEND}
	virtual/modutils
	ipppd? ( net-dialup/ppp )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	CONFIG_CHECK="PPP"
	linux-info_pkg_setup

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

	# patch all Makefiles to use our CFLAGS
	find . -name "Makefile*" -type f | \
	xargs -r sed -i -e "s:^\(CFLAGS.*=.*-Wall\) -O2:\1 \$(MYCFLAGS):g" \
		-e "s:^\(CFLAGS.*=.*\) -O[26] -fomit-frame-pointer:\1 \$(MYCFLAGS):g" \
		-e "s:^\(CFLAGS.*=.*\) -fomit-frame-pointer -O2:\1 \$(MYCFLAGS):g" \
		-e "s:^\(CFLAGS.*=.*\) -g -Wall:\1 \$(MYCFLAGS) -Wall:g" \
		-e "s:^\(CFLAGS.*=.*\) -Wall -g:\1 -Wall \$(MYCFLAGS):g" \
		-e "s:^\(CFLAGS.*=.*-Wall.*\) -O2 -g:\1 \$(MYCFLAGS):g" \
		-e "s:^\(CFLAGS.*= -Wall\)$:\1 \$(MYCFLAGS):g" \
		-e "s:^\(CFLAGS.*=\) -g$:\1 \$(MYCFLAGS):g" || die "sed failed"

	# install our config
	case "${I4L_CC}" in
		DE|AT|NL|LU|CH)
			# These countries are specially supported in the isdnlog source.
			sed -e "s:^CONFIG_ISDN_LOG_XX=:CONFIG_ISDN_LOG_${I4L_CC}=:g" \
				-e "s:^\(CONFIG_ISDN_LOG_CC_\)..=:\1${I4L_LANG}=:g" \
				-e "s:^CONFIG_ISDN_LOG_CC=.*$:#:g" \
				< ${FILESDIR}/config-${PV} > .config || die "failed to modify .config"
			;;
		*)
			# Others get a generic isdnlog.
			sed -e "s:^\(CONFIG_ISDN_LOG_CC=\).*$:\1'${I4L_CC_LOW}':g" \
				-e "s:^\(CONFIG_ISDN_LOG_CC_\)..=:\1${I4L_LANG}=:g" \
				< ${FILESDIR}/config-${PV} > .config || die "failed to modify .config"
			;;
	esac

	# build X clients
	useq X || \
		sed -i -e "s:^\(CONFIG_BUILDX11=.*\)$:# \1:g" \
			-e "s:^\(CONFIG_XISDNLOAD=.*\)$:# \1:g" \
			-e "s:^\(CONFIG_XMONISDN=.*\)$:# \1:g" .config

	# build ipppd
	useq ipppd || \
		sed -i -e "s:^\(CONFIG_IPPPD=.*\)$:# \1:g" \
			-e "s:^\(CONFIG_IPPPSTATS=.*\)$:# \1:g" .config

	# build isdnlog
	useq isdnlog  || sed -i -e "s:^\(CONFIG_ISDNLOG=.*\)$:# \1:g" .config

	# build eurofile (etf)
	useq eurofile || sed -i -e "s:^\(CONFIG_EUROFILE=.*\)$:# \1:g" .config

	# selecting database support for isdnlog (only ONE is possible)
	#useq mysql    || sed -i -e "s:^\(CONFIG_ISDNLOG_MYSQL.*=.*\)$:# \1:g" .config
	#useq oracle   || sed -i -e "s:^\(CONFIG_ISDNLOG_ORACLE.*=.*\)$:# \1:g"	.config
	#useq postgres || sed -i -e "s:^\(CONFIG_ISDNLOG_POSTGRES.*=.*\)$:# \1:g" .config

	# Patch in order to make generic config for countries which are not known to isdnlog source
	sed -i -e "s:\$(INSTALL_DATA) rate-:-\$(INSTALL_DATA) rate-:g" \
		-e "s:\$(INSTALL_DATA) holiday-:-\$(INSTALL_DATA) holiday-:g" isdnlog/Makefile.in

	# Patch path to isdnlog docs
	sed -i -e "s:^\(CONFIG_ISDNLOG_DOCDIR=\).*$:\1'/usr/share/doc/${PF}/isdnlog':g" .config

	# add --libdir to configure call in Makefile
	sed -i -e "s:\(\./configure \):\1--libdir=/usr/$(get_libdir) :g" Makefile

	# Fixing /usr/lib to /usr/$(get_libdir} (for multilib-strict)
	sed -i -e "s:/usr/lib:/usr/$(get_libdir):g" isdnctrl/Makefile.in

	# disable creation of /dev nodes
	sed -i -e "s:\(sh scripts/makedev.sh\):echo \1:g" Makefile
	sed -i -e "s:^\([[:space:]]*\)\(.*mknod.*capi20.*\)\$:\1# \2:g" \
		-e "s:^\([[:space:]]*\)\(.*rm.*capi20.*\)\$:\1# \2:g" \
		-e "s:^\([[:space:]]*\)\(.*chgrp.*capi20.*\)\$:\1true # \2:g" scripts/makedev.sh

	# if specified, convert all relevant files from latin1 to UTF-8
	if useq unicode; then
		einfo "Converting configs and docs to UTF-8"
		for i in isdnlog/samples/{isdn,rate}.conf* isdnlog/*-??.dat isdnlog/{Isdn,.country-alias}; do
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_compile() {
	gnuconfig_update
	for i in eicon; do
		cd $i && autoconf || \
			die "autoconf failed in dir $i"
		cd ..
	done
	make MYCFLAGS="$CFLAGS" subconfig || die "make subconfig failed"
	make MYCFLAGS="$CFLAGS" || die "make failed"
}

src_install() {
	keepdir /var/lib/isdn
	dodir /etc/conf.d /lib/firmware /usr/sbin

	useq isdnlog && dodir /usr/share/isdn
	(useq isdnlog || useq eurofile) && dodir /etc/isdn
	(useq X || useq isdnlog || useq eurofile) && dodir /usr/bin

	make DESTDIR=${D} install || die "make install failed"

	# move leftover firmware files to the right place
	mv -f ${D}/usr/share/isdn/{*.bin,*.btl,ISAR.BIN} ${D}/lib/firmware/
	rmdir --ignore-fail-on-non-empty ${D}/usr/share/isdn

	# remove obsolete firmware files (these are in net-dialup/isdn-firmware)
	rm -f ${D}/lib/firmware/{bip1120,dnload,ds4bri,dspdload,loadpg,pc_??_ca,prload,te_????}.*

	# install autoload/hotplug blacklist
	insinto /etc/hotplug/blacklist.d
	newins ${FILESDIR}/isdn.blacklist isdn

	# install init-scripts + configs
	newinitd ${FILESDIR}/isdn.initd isdn
	newconfd ${FILESDIR}/isdn.confd isdn
	newinitd ${FILESDIR}/hisax.initd hisax
	insinto /etc
	doins ${FILESDIR}/hisax.conf

	# install docs (base)
	dodoc NEWS README Mini-FAQ/isdn-faq.txt scripts/makedev.sh FAQ/_howto/xp*

	# install ipppd stuff
	if useq ipppd; then
		newinitd ${FILESDIR}/net.ippp0 net.ippp0
		insinto /etc/ppp
		doins ${FILESDIR}/{ioptions,options.ippp0}
		docinto ipppd
		dodoc LEGAL.ipppcomp ipppd/{README,README.*.ORIG,NOTES.IPPPD} ipppcomp/README.LZS  # ipppd/README.RADIUS
		docinto ipppd/example
		dodoc FAQ/_example/*.txt
		docinto ipppd/howto
		dodoc FAQ/_howto/{dns*,i4l_ipx*,isdn*,lan*,leased*,masq*,mppp*,ppp*,route*}
	fi

	# install isdnlog stuff
	if useq isdnlog; then
		newinitd ${FILESDIR}/isdnlog.initd isdnlog.contr0
		newconfd ${FILESDIR}/isdnlog.confd isdnlog.contr0

		insinto /usr/share/isdn
		doins isdnlog/*.dat

		insinto /etc/logrotate.d
		newins ${FILESDIR}/isdnlog.logrotated isdnlog

		insinto /etc/isdn  # install example isdnlog configs
		cp -f ${D}/etc/isdn/isdnlog.isdnctrl0.options ${D}/etc/isdn/isdnlog.options.example
		mv -f ${D}/etc/isdn/isdnlog.isdnctrl0.options ${D}/etc/isdn/isdnlog.options.contr0
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
		sed -i -e "s:/usr/lib/isdn/:/usr/share/isdn/:g"	${D}/etc/isdn/isdn.conf*

		docinto isdnlog
		dodoc isdnlog/{BUGS,CREDITS,FAQ,Isdn,NEWS,README*,TODO}
	   	dodoc FAQ/_howto/win* isdnlog/samples/provider
		docinto isdnlog/areacode
		dodoc areacode/*.doc
		docinto isdnlog/contrib/isdnbill
		dodoc isdnlog/contrib/isdnbill/{*.isdnbill,*.gz}
		docinto isdnlog/contrib/winpopup
		dodoc isdnlog/contrib/winpopup/*

		#if useq oracle; then
		#	docinto isdnlog/oracle
		#	dodoc isdnlog/isdnlog/oracle/*.sql
		#fi
	fi

	# install eurofile stuff
	if useq eurofile; then
		docinto eurofile
		dodoc eurofile/{CHANGES,INSTALL,README*,TODO}
		newdoc eurofile/src/wuauth/README README.AUTHLIB
		docinto eurofile/scripts
		dodoc eurofile/scripts/{eft_useradd,check_system,ix25test,eftd.sh,eftp.sh}
	fi
}

pkg_postinst() {
	# creating device-nodes (bah! should be handled by udev!)
	[ -c /dev/isdninfo -a -c /dev/isdnctrl0 ] || \
	sh 2>/dev/null < <(zcat /usr/share/doc/${PF}/makedev.sh.gz)

	einfo
	einfo "Please edit:"
	einfo
	einfo "- /etc/hisax.conf    if you have hisax supported cards"
	einfo "- /etc/ppp/*         critical if you need networking"
	einfo
	if useq isdnlog; then
		einfo "For isdnlog you should edit:"
		einfo
		einfo "- /etc/conf.d/isdnlog.contr0"
		einfo "- /etc/isdn/isdnlog.options.contr0"
		einfo "- /etc/isdn/*.conf"
		einfo
	fi
	einfo "/etc/init.d/isdn will save and restore your isdnctrl config."
	einfo "it will also handle the modem-register daemon."
	einfo
	if useq ipppd; then
		einfo "/etc/init.d/net.ippp0 will start synchronous PPP connections"
		einfo "which you need to set up using isdnctrl first!"
		einfo
	fi
	if useq isdnlog; then
		einfo "/etc/init.d/isdnlog.contr0 starts and stops isdnlog for contr0"
		einfo "You can symlink it to isdnlog.contr1 and copy the corresponding"
		einfo "configs if you have more than one card."
		einfo
	fi
}
