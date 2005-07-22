# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/eqe/eqe-1.0.4.ebuild,v 1.2 2005/07/22 10:02:51 dholm Exp $

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
	media-gfx/imagemagick
	virtual/tetex"

src_install() {
	dobin eqe eqedit || die
	doman *.1.gz
}
