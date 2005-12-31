# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/eqe/eqe-1.2.0.ebuild,v 1.1 2005/12/31 14:51:48 nattfodd Exp $

DESCRIPTION="A small LaTeX editor that produces images, with drag and drop
support."
HOMEPAGE="http://rlehy.free.fr/"
SRC_URI="http://rlehy.free.fr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE=""
DEPEND="dev-perl/gtk2-perl
	dev-perl/File-Slurp
	dev-perl/Template-Toolkit
	media-gfx/imagemagick
	virtual/tetex"

src_compile() {
	cd ${S}/doc
	pod2man eqe.pod > eqe.1
	pod2man eqedit.pod > eqedit.1
}

src_install() {
	dobin src/eqe src/eqedit || die
	doman doc/*.1
	insinto /usr/share/${P}
	doins src/template.tt.tex
	dodoc FAQ TODO README changelog
}
