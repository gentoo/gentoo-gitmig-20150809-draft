# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbutton/wmbutton-0.5.ebuild,v 1.6 2004/11/24 05:08:13 weeve Exp $

inherit eutils

IUSE=""

DESCRIPTION="wmbutton is a dockapp application that displays nine configurable buttons"
SRC_URI="http://www.dockapps.org/download.php/id/454/${P}.tar.gz"
HOMEPAGE="http://www.dockapps.org/file.php/id/241"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"

src_unpack()
{
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-cflags.patch
	cp ${FILESDIR}/${PN}-buttons.xpm buttons.xpm
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
