# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/moodss/moodss-20.0.ebuild,v 1.2 2005/06/20 14:11:49 matsuu Exp $

inherit eutils

DESCRIPTION="Modular Object Oriented Dynamic SpreadSheet"
HOMEPAGE="http://moodss.sourceforge.net/"
SRC_URI="mirror://sourceforge/moodss/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mysql perl python"

DEPEND=">=dev-lang/tcl-8.4"

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

pkg_setup() {
	if ! built_with_use dev-lang/tcl threads ; then
		eerror "Tcl is missing threads support."
		eerror "Please add 'threads' to your USE flags, and re-emerge tcl."
		die "tcl needs threads support"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e 's:%_datadir:/usr/share:' \
		-e 's:%_bindir:/usr/bin:' ${PN}.desktop || die
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make \
		ROOTDIR=${D} \
		MOODSSDOCDIR=/usr/share/doc/${PF} \
		install || die

	insinto /usr/share/applications
	doins ${PN}.desktop
	insinto /usr/share/pixmaps
	doins ${PN}.png
	insinto /usr/share/${PN}
	doins linux.moo
}
