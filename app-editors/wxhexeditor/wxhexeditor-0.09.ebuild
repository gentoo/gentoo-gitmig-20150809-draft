# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/wxhexeditor/wxhexeditor-0.09.ebuild,v 1.1 2010/08/31 04:16:58 dirtyepic Exp $

EAPI=3
WX_GTK_VER=2.8

inherit eutils wxwidgets

MY_PN="wxHexEditor"

DESCRIPTION="A cross-platform hex editor designed specially for large files."
HOMEPAGE="http://wxhexeditor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-v${PV}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc45.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
}
