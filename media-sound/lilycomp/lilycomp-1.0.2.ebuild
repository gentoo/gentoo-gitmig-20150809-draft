# Copyright 2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilycomp/lilycomp-1.0.2.ebuild,v 1.1 2004/11/22 04:56:20 agriffis Exp $

DESCRIPTION="graphical note entry program for use with LilyPond"
HOMEPAGE="http://lilycomp.sourceforge.net/"
SRC_URI="mirror://sourceforge/lilycomp/${P/-/.}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/python"

S=${WORKDIR}/${P/-/.}

src_install() {
	newbin lilycomp.py lilycomp
	dohtml *.html
	dodoc [[:upper:]]*
}
