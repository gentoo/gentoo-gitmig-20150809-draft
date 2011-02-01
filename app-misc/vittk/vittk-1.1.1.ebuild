# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vittk/vittk-1.1.1.ebuild,v 1.2 2011/02/01 11:23:36 radhermit Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="A front end for Taskwarrior (app-misc/task)"
HOMEPAGE="http://taskwarrior.org/wiki/taskwarrior/Vittk"
SRC_URI="http://taskwarrior.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/tcl"
RDEPEND="${DEPEND}
	dev-lang/tk
	app-misc/task"

src_prepare() {
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-dirs.patch
	eautoreconf
}

src_configure() {
	econf --docdir="${EPREFIX}"/usr/share/doc/${PF}
}
