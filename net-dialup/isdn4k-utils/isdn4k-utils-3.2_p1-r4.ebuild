# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.2_p1-r4.ebuild,v 1.2 2004/02/18 19:03:35 azarah Exp $

IUSE="X"
VBOX_V=0.1.9
MY_PVR=${PV}-r2

S=${WORKDIR}/${PN}
DESCRIPTION="ISDN-4-Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/${PN}.v3.2p1.tar.bz2
	http://smarden.org/pape/vbox3/vbox3_${VBOX_V}.tar.gz"
HOMEPAGE="http://www.isdn4linux.de/"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha"
LICENSE="GPL-2"

RDEPEND=">=sys-apps/portage-2.0.47-r10
	virtual/glibc
	sys-libs/ncurses
	sys-libs/gdbm
	X? (
		virtual/x11
		dev-lang/tcl
	)"

DEPEND="${RDEPEND}
	virtual/linux-sources
	sys-devel/libtool
	sys-devel/automake"

src_unpack() {
	unpack ${A}
	# Get country code from I4L_CC variable
	# default country: DE (Germany)
	export I4L_CC=`echo -n "${I4L_CC}" | tr "[:lower:]" "[:upper:]"`
	[ "X${I4L_CC}" == "X" ] && export I4L_CC=DE
	export I4L_CC_LOW=`echo -n "${I4L_CC}" | tr "[:upper:]" "[:lower:]"`
	cd ${S}

	# Patch .config file to suit our needs
	cat ${FILESDIR}/${PV}-r4/config | { \
		if use X >/dev/null; then
			cat
		else
			sed -e s/CONFIG_BUILDX11=y/#/ -e s/CONFIG_XISDNLOAD=y/#/ -e s/CONFIG_XMONISDN=y/#/;
		fi; } | { \
		case "${I4L_CC}" in
			DE|AT|CH|NL)
				# These countries are specially supported in the isdnlog source.
				sed -e s/CONFIG_ISDN_LOG_XX=y/CONFIG_ISDN_LOG_${I4L_CC}=y/ -e s/CONFIG_ISDN_LOG_CC=\'\'/#/
				;;
			*)
				# Others get a generic isdnlog.
				sed s/CONFIG_ISDN_LOG_CC=\'\'/CONFIG_ISDN_LOG_CC=\'${I4L_CC_LOW}\'/
				;;
		esac } \
		> .config || die

	# Patch in order to make generic config for countries which are not known to isdnlog source
	epatch ${FILESDIR}/${MY_PVR}/gentoo.patch

	# disabling device creation the easy way:
	echo "#!/bin/bash" > scripts/makedev.sh
	echo "true" >> scripts/makedev.sh

	epatch ${FILESDIR}/gcc33-multiline.patch

	for x in capi20 capiinfo capiinit
	do
		cd ${S}/${x}
		[ -f ltmain.sh ] && libtoolize --force
		rm -f missing
		aclocal
		automake --add-missing
		autoconf
	done
}

src_compile() {
	make subconfig || die
	make || die

	cd ${S}/../vbox3-${VBOX_V}
	econf
	emake || die
}

src_install() {
	dodir /dev /sbin /usr/bin
	make DESTDIR=${D} install || die
	rm -rf ${D}/usr/doc ${D}/dev
	dodoc COPYING NEWS README Mini-FAQ/isdn-faq.txt

	cd ${FILESDIR}/${MY_PVR}
	dodir /etc/init.d /etc/conf.d /etc/ppp /var/lib/isdn4linux

	exeinto /etc/init.d
	doexe net.ippp0
	newexe isdn4linux.init isdn4linux

	insinto /etc/conf.d
	newins isdn4linux.conf isdn4linux

	exeinto /etc/ppp
	insinto /etc/ppp
	doexe ip-up
	dosym ip-up /etc/ppp/ip-down
	doins ip-down.ippp0
	doins ioptions
	doins options.ippp0

	cd ${S}/../vbox3-${VBOX_V}
	einstall || die
}

pkg_postinst() {
	einfo
	einfo "Please edit:"
	einfo
	einfo "- /etc/modules.autoload to contain your ISDN kernel modules"
	einfo "- /etc/isdn/* (critical)"
	einfo "- /etc/ppp/* (critical)"
	einfo
	einfo "/etc/init.d/isdn4linux will save and restore your isdnctrl config."
	einfo "/etc/init.d/net.ippp0 will start synchronous PPP connections which"
	einfo "you need to set up using isdnctrl first!"
	einfo

}
