# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilycomp/lilycomp-1.0.2.ebuild,v 1.5 2007/06/07 15:13:12 genstef Exp $

inherit python

MY_P="${P/-/.}"

DESCRIPTION="graphical note entry program for use with LilyPond"
HOMEPAGE="http://lilycomp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_tkinter_exists
}

src_install() {
	newbin lilycomp.py lilycomp || die "newbin failed"
	dohtml *.html
	dodoc [[:upper:]]*
}
