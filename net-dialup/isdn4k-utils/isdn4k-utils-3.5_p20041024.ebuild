# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.5_p20041024.ebuild,v 1.1 2004/11/09 16:34:43 mrness Exp $

inherit eutils

MY_V=${PV/*_p/}
MY_PV=${PN}-CVS-${MY_V:0:4}-${MY_V:4:2}-${MY_V:6:2}
VBOX_V=0.1.9
S=${WORKDIR}/${MY_PV}
DESCRIPTION="ISDN-4-Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/CVS-Snapshots/${MY_PV}.tar.bz2
	http://smarden.org/pape/vbox3/vbox3_${VBOX_V}.tar.gz"
HOMEPAGE="http://www.isdn4linux.de/"

KEYWORDS="~x86 ~amd64 ~alpha"
LICENSE="GPL-2"
SLOT="0"
IUSE="X"

RDEPEND=">=sys-apps/portage-2.0.47-r10
	virtual/libc
	sys-libs/ncurses
	sys-libs/gdbm
	dev-lang/tcl
	X? (
		virtual/x11
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

	# fix for 2.6 headers
	find . -name \*.c | xargs sed -i -e 's:linux/capi.h>$:linux/compiler.h>\n#include <linux/capi.h>:g'

	# Patch .config file to suit our needs
	cat ${FILESDIR}/${PV}/config | { \
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
	epatch ${FILESDIR}/${PV}/gentoo.patch

	for x in capi20 capiinfo capiinit ../vbox3-${VBOX_V}
	do
		cd ${S}/${x}
		[ -f ltmain.sh ] && libtoolize --force
		rm -f missing
		aclocal
		automake --add-missing
		autoconf
	done

	cd ${WORKDIR}/vbox3-${VBOX_V}
	epatch ${FILESDIR}/${PV}/vbox-makefile.am.patch || die "failed to patch vbox"
}

src_compile() {
	make subconfig || die
	make || die

	cd ${S}/../vbox3-${VBOX_V}
	econf || die "econf failed"
	emake || die
}

src_install() {
	dodir /dev /sbin /usr/bin
	make DESTDIR=${D} install || die "make install failed"
	dodoc COPYING NEWS README Mini-FAQ/isdn-faq.txt scripts/makedev.sh

	cd ${FILESDIR}/${PV}
	dodir /etc/init.d /etc/conf.d /etc/ppp /var/lib/isdn4linux

	exeinto /etc/init.d
	doexe net.ippp0
	newexe isdn4linux.init isdn4linux

	insinto /etc/conf.d
	newins isdn4linux.conf isdn4linux

	exeinto /etc/ppp
	insinto /etc/ppp
	doexe ip-up ip-down
	doins ioptions
	doins options.ippp0

	cd ${S}/../vbox3-${VBOX_V}
	einstall || die "cannot install vbox3"

	cd ${D}/etc/isdn
	epatch ${FILESDIR}/${PV}/pathfix.patch || die
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
