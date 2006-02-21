# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbutton/wmbutton-0.5.ebuild,v 1.9 2006/02/21 21:43:30 nelchael Exp $

inherit eutils

IUSE=""

DESCRIPTION="wmbutton is a dockapp application that displays nine configurable buttons"
SRC_URI="http://www.dockapps.org/download.php/id/454/${P}.tar.gz
	mirror://gentoo/${PN}-buttons.xpm"
HOMEPAGE="http://www.dockapps.org/file.php/id/241"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc x86"

src_unpack()
{
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-cflags.patch
	cp ${DISTDIR}/${PN}-buttons.xpm buttons.xpm
}

src_compile()
{
	emake CFLAGS="${CFLAGS}" || die "make failed"
}

src_install()
{
	exeinto /usr/bin
	doexe wmbutton

	insinto /usr/share/doc/${PF}
	doins ${FILESDIR}/sample.wmbutton

	dodoc README

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
