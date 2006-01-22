# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmi/wmi-10.ebuild,v 1.7 2006/01/22 13:05:30 tove Exp $

DESCRIPTION="WMI is a new window manager for X11, which combines the best features of larswm, ion, evilwm and ratpoison into one window manager."
SRC_URI="http://wmii.de/download/${P}.tar.gz"
HOMEPAGE="http://wmii.de/"

LICENSE="as-is"
RDEPEND="|| ( ( x11-libs/libSM
			x11-libs/libXft )
		virtual/x11 )
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype"

DEPEND="${RDEPEND}
	|| ( ( x11-proto/xproto
			x11-libs/libXt )
		virtual/x11 )"

KEYWORDS="x86 ppc ~ppc-macos amd64"
SLOT="0"
IUSE=""

pkg_setup() {
	echo
	einfo "wmi is outdated and not maintained, because upstream is"
	einfo "convinced that wmi sucks (taken from homepage)."
	einfo "Please try x11-wm/wmii. Hopefully wmii can replace wmi soon."
	echo
}

src_compile() {
	econf --with-slot-support --with-xft-support || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS CONTRIB COPYING ChangeLog FAQ INSTALL LICENSE.txt \
		  NEWS README TODO

	docinto examples
	dodoc examples/*.sh

	docinto examples/themes
	dodoc examples/themes/*

	echo -e "#!/bin/sh\n/usr/bin/wmi" > "${T}"/wmi
	exeinto /etc/X11/Sessions
	doexe "${T}"/wmi

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/wmi.desktop
}
