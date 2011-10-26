# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-2.5.1.ebuild,v 1.3 2011/10/26 23:28:18 ssuominen Exp $

EAPI=4

KDE_LINGUAS="cs da de es fr hr hu it ja nb nn pl pt ro ru sk sr sv tr zh_CN"
KDE_HANDBOOK="optional"

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
	mv kdbg/doc . || die
	sed -i -e '/add_subdirectory(doc)/d' kdbg/CMakeLists.txt || die
	echo "add_subdirectory ( doc ) " >> CMakeLists.txt || die
	kde4-base_src_prepare
}

src_install() {
	kde4-base_src_install
	rm -f "${ED}"usr/share/doc/${PF}/ChangeLog-pre*
}
