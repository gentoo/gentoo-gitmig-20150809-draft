# Copyright 1999-2004 Gentoo Technologies, Inc., Doug Goldstein
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/y-windows/y-windows-0.2.ebuild,v 1.2 2004/02/29 12:30:24 dholm Exp $

DESCRIPTION="Y Windows"
HOMEPAGE="http://www.y-windows.org/"
SRC_URI="http://www.cardoe.com/y-base/patches/Y-patch26.tar.bz2"
LICENSE="GPL-2 LGPL-2 CPL-1.0"
SLOT="0"

KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="virtual/x11
	>=automake-1.8
	>=autoconf-2.58
	>=media-libs/libsdl-1.2.0
	>=media-libs/freetype-2.1.3
	=dev-libs/libsigc++-1.0*
	>=x11-libs/libiterm-mbt-0.5"

S=${WORKDIR}/Y--devel--0.2--patch-26

src_compile() {
	ewarn Please wait while ./autogen.sh runs... no output will appear.
	chmod u+x autogen.sh
	WANT_AUTOMAKE=1.8 ./autogen.sh

	econf || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die
}

pkg_postinst() {
	ewarn Please check /etc/Y/default.conf and change your keymap to "us" if you\'re in the US.
	echo
	ewarn Current apps are ycalculator, yiterm, yclock, and ysample.
	echo
	ewarn To start Y just run startY while in X.
}
