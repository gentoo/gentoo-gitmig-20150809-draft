# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.12-r2.ebuild,v 1.5 2003/04/12 10:23:45 cybersystem Exp $

inherit commonbox flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on Blackbox -- has tabs. Remember patch applied."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${PN}-gentoo.diff.bz2
	http://fluxbox.org/download/patches/unofficial-fluxbox-0.1.12-remember-patch.bz2"
HOMEPAGE="http://fluxbox.sf.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

mydoc="ChangeLog COPYING NEWS"
myconf="--enable-xinerama"
filter-flags -fno-exceptions
export WANT_AUTOMAKE_1_6=1
export WANT_AUTOCONF_2_5=1

src_unpack() {

if [ ! "`use nls`" ]
then
	ewarn "You currently have -nls in your USE. This build of Fluxbox will not"
	ewarn "build if nls is disabled. Please try:"
	ewarn "USE=\"nls\" emerge fluxbox"
	exit 1
fi

	unpack ${P}.tar.gz

	cd ${S}
	bzcat ${DISTDIR}/unofficial-fluxbox-0.1.12-remember-patch.bz2 | patch -p1 || die
	bzcat ${DISTDIR}/${PN}-gentoo.diff.bz2 | patch -p1 || die

	ssed -i "s:blackbox.cat:fluxbox.cat:" src/main.cc
}

src_compile() {

	commonbox_src_compile

	cd data
	make \
		pkgdatadir=/usr/share/commonbox init
}


src_install() {

	commonbox_src_install
	cd data
	insinto /usr/share/commonbox
	doins init
	insinto /usr/share/commonbox/fluxbox
	doins keys
}
