# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/surf/surf-1.0.4-r1.ebuild,v 1.3 2004/07/14 18:31:08 agriffis Exp $

inherit eutils

DESCRIPTION="a tool to visualize algebraic curves and algebraic surfaces"
HOMEPAGE="http://surf.sourceforge.net/"
SRC_URI="mirror://sourceforge/surf/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
IUSE="gtk"

RDEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	>=dev-libs/gmp-2
	media-libs/tiff
	media-libs/jpeg"

DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc33.patch
}

src_compile() {
	econf `use_enable gtk gui` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install install-man || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
	for d in examples/*
	do
		docinto ${d}
		dodoc ${d}/*
	done
}
