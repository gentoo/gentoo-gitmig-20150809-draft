# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/kahakai/kahakai-0.6.2_p20040306.ebuild,v 1.4 2005/02/20 10:46:29 usata Exp $

inherit eutils

IUSE="truetype xinerama ruby"

DESCRIPTION="A language agnostic scriptable window manager based on Waimea."
HOMEPAGE="http://kahakai.sf.net/"
#SRC_URI="mirror://sourceforge/kahakai/${P}.tar.bz2"
SRC_URI="mirror://gentoo/${P/_p/-}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc -alpha -sparc"

RDEPEND="virtual/x11
	truetype? ( virtual/xft )
	ruby? ( || ( >=dev-lang/ruby-1.8 dev-lang/ruby-cvs ) )
	>=dev-lang/swig-1.3.20
	>=media-libs/imlib2-1.1.0
	dev-util/pkgconfig
	media-fonts/artwiz-fonts
	dev-libs/boost"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57-r1
	>=sys-devel/automake-1.7.2
	sys-devel/libtool"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${P}-rubyscript-gentoo.diff
	epatch ${FILESDIR}/${P}-compilation_fix.patch
}

src_compile() {
	libtoolize --copy --force || die
	./autogen.sh || die
	econf \
		$(use_enable ruby) \
		$(use_enable xinerama) \
		$(use_enable truetype xft) || die
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
