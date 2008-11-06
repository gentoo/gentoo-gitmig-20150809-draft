# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/juffed/juffed-0.4.ebuild,v 1.1 2008/11/06 15:46:52 yngwin Exp $

EAPI=1
inherit qt4

MY_P=${PN}_${PV}

DESCRIPTION="QScintilla-based tabbed text editor with syntax highlighting"
HOMEPAGE="http://www.qt-apps.org/content/show.php/JuffEd?content=59940"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/qscintilla-2.1
	|| ( x11-libs/qt-gui:4 =x11-libs/qt-4.3*:4 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# force our current cxxflags and ldflags, and turn off warnings in tests, bug 231921
	epatch "${FILESDIR}"/${PN}-0.3-configure.patch
}

src_compile() {
	# with econf it chokes on Unrecognized option: --host=...
	./configure --qmake=qmake --prefix=/usr
	emake || die "Make failed!"
}

src_install() {
	emake FAKE_ROOT="${D}" install || die "Make install failed!"
	dodoc ChangeLog README
	rm "${D}"/usr/share/juffed/{COPYING,README}
}
