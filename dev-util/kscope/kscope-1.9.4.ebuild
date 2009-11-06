# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kscope/kscope-1.9.4.ebuild,v 1.3 2009/11/06 22:23:03 ssuominen Exp $

EAPI=2
inherit multilib qt4

DESCRIPTION="Source Editing Environment for KDE"
HOMEPAGE="http://kscope.sourceforge.net/"
SRC_URI="mirror://sourceforge/kscope/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	>=x11-libs/qscintilla-2[qt4]"
DEPEND="${RDEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	sed -i -e "s:/usr/local:/usr:" config || die
	sed -i \
		-e "s:/lib:/$(get_libdir):g" \
		core/core.pro cscope/cscope.pro editor/editor.pro || die
}

src_configure() {
	eqmake4 ${PN}.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc ChangeLog
}
