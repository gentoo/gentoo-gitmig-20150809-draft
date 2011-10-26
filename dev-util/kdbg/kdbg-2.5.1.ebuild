# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-2.5.1.ebuild,v 1.1 2011/10/26 20:35:33 ssuominen Exp $

EAPI=4
inherit kde4-base

DESCRIPTION="A graphical debugger interface"
HOMEPAGE="http://www.kdbg.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-devel/gdb"
DEPEND="${RDEPEND}"

DOCS=( BUGS README ReleaseNotes-${PV} TODO )

src_prepare() {
	sed -i -e '/add_subdirectory(doc)/d' kdbg/CMakeLists.txt || die
}

src_install() {
	kde4-base_src_install
	dohtml -r kdbg/doc/*
	rm -f "${ED}"usr/share/doc/${PF}/ChangeLog-pre*
}
