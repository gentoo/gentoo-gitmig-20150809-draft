# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/moodss/moodss-18.1.ebuild,v 1.3 2004/11/06 15:42:10 pyrania Exp $

DESCRIPTION="Modular Object Oriented Dynamic SpreadSheet"
HOMEPAGE="http://jfontain.free.fr/moodss/"
SRC_URI="http://jfontain.free.fr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mysql perl python"

DEPEND=">=dev-lang/tk-8.3.1"

RDEPEND="${DEPEND}
	>=dev-tcltk/blt-2.4z
	>=dev-tcltk/tktable-2.7
	>=dev-tcltk/scwoop-4.0
	>=dev-tcltk/tkpiechart-6.1
	>=dev-tcltk/bwidget-1.7
	>=dev-tcltk/tclxml-2.6
	>=dev-tcltk/tcldom-2.6
	dev-tcltk/tcllib
	mysql? ( dev-tcltk/mysqltcl )
	perl? ( dev-tcltk/tclperl )
	python? ( dev-tcltk/tclpython )"
#	odbc? ( dev-tcltk/tclodbc )

src_compile() {
	emake || die
}

src_install() {
	make ROOTDIR=${D} install || die

}
