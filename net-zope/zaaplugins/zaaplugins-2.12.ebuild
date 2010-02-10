# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zaaplugins/zaaplugins-2.12.ebuild,v 1.8 2010/02/10 22:47:04 ssuominen Exp $

EAPI=2
inherit zproduct

DESCRIPTION="A collection of ZAttachmentAttribute Plugins"
HOMEPAGE="http://ingeniweb.sourceforge.net/"
SRC_URI="mirror://sourceforge/ingeniweb/ZAAPlugins-${PV}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=net-zope/zattachmentattribute-2.12
	>=app-text/wv-1.0.0
	>=app-text/xlhtml-0.5
	>=app-text/poppler-0.12.3-r3[utils]"

ZPROD_LIST="ZAAPlugins"

src_install () {
	rm -rf "${WORKDIR}"/ZAAPlugins/MSExcel/win32
	rm -rf "${WORKDIR}"/ZAAPlugins/MSPowerPoint/win32
	rm -f  "${WORKDIR}"/ZAAPlugins/MSPowerPoint/ppthtml.exe
	rm -rf "${WORKDIR}"/ZAAPlugins/MSWord/win32
	rm -rf "${WORKDIR}"/ZAAPlugins/PDF/win32
	zproduct_src_install
}
