# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/kahakai/kahakai-0.6.2.ebuild,v 1.1 2004/02/11 05:36:16 bcowan Exp $

IUSE="truetype xinerama ruby"
S=${WORKDIR}/${P}

DESCRIPTION="A language agnostic scriptable window manager based on Waimea."
HOMEPAGE="http://kahakai.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc -alpha -sparc"

DEPEND="virtual/x11
	truetype? ( virtual/xft )
	ruby? ( dev-lang/ruby )
	>=dev-lang/swig-1.3.20
	media-libs/imlib2
	dev-util/pkgconfig
	media-fonts/artwiz-fonts
	dev-libs/boost"

src_compile() {
	econf \
		`use_enable ruby` \
		`use_enable xinerama` \
		`use_enable truetype xft` || die
	emake || die
}

src_install() {
	einstall || die
	cd doc
	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO

	exeinto /etc/X11/Sessions
	echo "/usr/bin/kahakai" > ${T}/kahakai
	doexe ${T}/kahakai
}
