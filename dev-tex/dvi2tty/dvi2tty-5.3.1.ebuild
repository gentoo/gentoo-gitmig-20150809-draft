# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/dvi2tty/dvi2tty-5.3.1.ebuild,v 1.5 2004/12/28 20:59:04 absinthe Exp $

inherit eutils
DESCRIPTION="Preview dvi-files on text-only devices"
HOMEPAGE="http://www.ctan.org/tex-archive/dviware/"
SRC_URI="ftp://ftp.mesa.nl/pub/dvi2tty/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/dvi2tty-gcc.patch
}

src_compile() {
	emake || die
}

src_install() {
	dobin dvi2tty disdvi
	doman dvi2tty.1 disdvi.1
}
