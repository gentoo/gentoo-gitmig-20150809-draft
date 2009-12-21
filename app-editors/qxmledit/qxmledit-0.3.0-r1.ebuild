# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qxmledit/qxmledit-0.3.0-r1.ebuild,v 1.1 2009/12/21 15:36:04 hwoarang Exp $

EAPI="2"

inherit qt4-r2

MY_PN="${PN}-src"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Qt4 XML Editor"
HOMEPAGE="http://code.google.com/p/qxmledit/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src/"

DOCS="AUTHORS NEWS README TODO"
DOCSDIR="${WORKDIR}/${P}/"

src_prepare(){
	# fix installation path
	sed -i "/^target.path/ s/\/opt\/${PN}/\/usr\/bin/" QXmlEdit.pro || \
		die "failed to fix installation path"
	# fix translations
	sed -i "/^translations.path/ s/\/opt/\/usr\/share/" QXmlEdit.pro || \
		die "failed to fix translations"
	qt4-r2_src_prepare
}
