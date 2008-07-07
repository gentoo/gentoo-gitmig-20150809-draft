# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/juffed/juffed-0.3_beta20080705.ebuild,v 1.1 2008/07/07 23:58:09 yngwin Exp $

EAPI=1
inherit qt4

MY_P=${PN}_${PV/_beta20080705/-beta2}

DESCRIPTION="QScintilla-based tabbed text editor with syntax highlighting"
HOMEPAGE="http://www.qt-apps.org/content/show.php/JuffEd?content=59940"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/qscintilla-2.1
	|| ( >=x11-libs/qt-4.2:4
		x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

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

