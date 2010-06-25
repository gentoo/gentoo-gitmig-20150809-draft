# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/wxmacmolplt/wxmacmolplt-7.4.ebuild,v 1.4 2010/06/25 09:57:43 jlec Exp $

EAPI="2"
WX_GTK_VER=2.8

inherit base eutils autotools wxwidgets

DESCRIPTION="Chemical 3D graphics program with GAMESS input builder"
HOMEPAGE="http://www.scl.ameslab.gov/MacMolPlt/"

SRC_URI="http://www.scl.ameslab.gov/MacMolPlt/download/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="flash"

DEPEND="x11-libs/wxGTK:2.8[X,opengl]
		flash? ( <media-libs/ming-0.4 )"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "/^dist_doc_DATA/d" Makefile.am \
		|| die "Failed to disable installation of LICENSE file"
	eautoreconf
}

src_configure() {
	econf $(use_with flash ming)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	doicon resources/${PN}.png
	make_desktop_entry ${PN} wxMacMolPlt ${PN} "Science;Education"
}
