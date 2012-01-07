# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/moodss/moodss-21.5.ebuild,v 1.6 2012/01/07 21:06:57 xarthisius Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Modular Object Oriented Dynamic SpreadSheet"
HOMEPAGE="http://moodss.sourceforge.net/"
SRC_URI="mirror://sourceforge/moodss/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="mysql perl python"

DEPEND=">=dev-lang/tcl-8.4[threads]"

RDEPEND="${DEPEND}
	>=dev-lang/tk-8.4
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
#	sqlite? ( >=dev-db/sqlite-tcl-2.8.6 )
#	odbc? ( dev-tcltk/tclodbc )

src_prepare() {
	sed -i -e 's:%_datadir:/usr/share:' \
		-e 's:%_bindir:/usr/bin:' ${PN}.desktop || die
	sed -i -e "s:/usr/lib:/usr/$(get_libdir):" Makefile || die
	epatch "${FILESDIR}"/${PV}-ldflags.patch
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		CC="$(tc-getCC)" || die
}

src_install() {
	make \
		ROOTDIR="${D}" \
		MOODSSDOCDIR=/usr/share/doc/${PF} \
		install || die

	domenu ${PN}.desktop
	doicon ${PN}.png
	insinto /usr/share/${PN}; doins linux.moo
}
