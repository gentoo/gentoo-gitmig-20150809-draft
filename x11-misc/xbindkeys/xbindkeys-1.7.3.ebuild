# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbindkeys/xbindkeys-1.7.3.ebuild,v 1.4 2006/08/30 19:42:13 hansmi Exp $

IUSE="guile tcltk"

DESCRIPTION="Tool for launching commands on keystrokes"
SRC_URI="http://hocwp.free.fr/xbindkeys/${P}.tar.gz"
HOMEPAGE="http://hocwp.free.fr/xbindkeys/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~ppc-macos ~ppc64 sparc x86"
SLOT="0"

RDEPEND="|| ( x11-libs/libX11 virtual/x11 )
	guile? ( dev-util/guile )
	tcltk? ( dev-lang/tk )"

DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

src_compile() {

	local myconf
	use tcltk || myconf="${myconf} --disable-tk"
	use guile || myconf="${myconf} --disable-guile"

	econf ${myconf} || die
	emake DESTDIR=${D} || die


}

src_install() {

	emake DESTDIR=${D} \
		BINDIR=/usr/bin install || die "Installation failed"

}

