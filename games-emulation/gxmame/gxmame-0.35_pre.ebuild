# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gxmame/gxmame-0.35_pre.ebuild,v 1.2 2005/01/22 05:08:26 vapier Exp $

MY_P="${PN}-${PV/_pre/cvs}"
DESCRIPTION="frontend for XMame using the GTK library"
HOMEPAGE="http://gxmame.sourceforge.net/"
SRC_URI="mirror://sourceforge/gxmame/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls joystick"

DEPEND="virtual/x11
	dev-libs/expat
	=x11-libs/gtk+-2*
	=dev-libs/glib-2*
	sys-libs/zlib"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:-O2 -fomit-frame-pointer -ffast-math:${CFLAGS}:" \
		-e "s:-O2:${CFLAGS}:" \
		configure || die "sed configure"
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable joystick) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
