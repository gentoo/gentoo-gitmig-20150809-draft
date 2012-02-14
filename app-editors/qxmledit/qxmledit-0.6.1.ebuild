# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qxmledit/qxmledit-0.6.1.ebuild,v 1.3 2012/02/14 17:14:28 tove Exp $

EAPI="2"

inherit qt4-r2

MY_P="qxmledit-${PV}-src"

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
	sed -i "/^INST_DIR/ s/\/opt\/${PN}/\/usr\/bin/" QXmlEdit.pro || \
		die "failed to fix installation path"
	# fix translations
	sed -i "/^INST_DATA_DIR/ s/\/opt/\/usr\/share/" QXmlEdit.pro || \
		die "failed to fix translations"
	qt4-r2_src_prepare
}

src_install(){
	qt4-r2_src_install
	newicon "${S}"/images/icon.png ${PN}.png
	make_desktop_entry QXmlEdit QXmlEdit ${PN} "Qt;Utility;TextEditor"
}
