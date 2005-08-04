# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbindkeys/xbindkeys-1.7.2.ebuild,v 1.2 2005/08/04 08:15:16 corsair Exp $

IUSE="guile tcltk"

DESCRIPTION="Tool for launching commands on keystrokes"
SRC_URI="http://hocwp.free.fr/xbindkeys/${P}.tar.gz"
HOMEPAGE="http://hocwp.free.fr/xbindkeys/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"

DEPEND="virtual/x11
	guile? ( dev-util/guile )
	tcltk? ( dev-lang/tk )"

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

