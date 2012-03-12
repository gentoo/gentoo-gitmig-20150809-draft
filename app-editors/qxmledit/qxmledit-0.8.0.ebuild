# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qxmledit/qxmledit-0.8.0.ebuild,v 1.1 2012/03/12 21:06:35 hwoarang Exp $

EAPI=4

inherit multilib qt4-r2

MY_P="qxmledit-${PV}-src"

DESCRIPTION="Qt4 XML Editor"
HOMEPAGE="http://code.google.com/p/qxmledit/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	x11-libs/qt-xmlpatterns:4"
RDEPEND="${DEPEND}"

DOCS="AUTHORS NEWS README TODO"
DOCSDIR="${WORKDIR}/${P}/"

src_prepare() {
	# fix doc dir
	sed -i "/^INST_DOC_DIR/ s|/opt/${PN}|/usr/share/doc/${PF}|" src/QXmlEdit.pro || \
		die "failed to fix installation path"
	# fix installation path
	sed -i "/^INST_DIR/ s|/opt/${PN}|/usr/bin|" src/QXmlEdit.pro || \
		die "failed to fix installation path"
	# fix widget library
	sed -i "/^INST_DIR/ s|/opt/${PN}|/usr/$(get_libdir)|" \
		src/QXmlEditWidget.pro || die "failed to fix library installation path"
	# fix translations
	sed -i "/^INST_DATA_DIR/ s|/opt|/usr/share|" src/QXmlEdit{,Widget}.pro || \
		die "failed to fix translations"
	qt4-r2_src_prepare
}

src_install() {
	qt4-r2_src_install
	newicon src/images/icon.png ${PN}.png
	make_desktop_entry QXmlEdit QXmlEdit ${PN} "Qt;Utility;TextEditor"
}
