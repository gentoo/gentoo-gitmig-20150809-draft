# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zaaplugins/zaaplugins-2.12.ebuild,v 1.6 2009/03/30 14:02:02 loki_val Exp $

inherit zproduct

DESCRIPTION="A collection of ZAttachmentAttribute Plugins"
HOMEPAGE="http://ingeniweb.sourceforge.net/"
SRC_URI="mirror://sourceforge/ingeniweb/ZAAPlugins-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~ppc ~x86"

DEPEND=">=net-zope/zattachmentattribute-2.12
	>=app-text/wv-1.0.0
	>=app-text/xlhtml-0.5
	>=virtual/poppler-utils-0.5"

ZPROD_LIST="ZAAPlugins"

src_install () {
	rm -rf "${WORKDIR}"/ZAAPlugins/MSExcel/win32
	rm -rf "${WORKDIR}"/ZAAPlugins/MSPowerPoint/win32
	rm -f  "${WORKDIR}"/ZAAPlugins/MSPowerPoint/ppthtml.exe
	rm -rf "${WORKDIR}"/ZAAPlugins/MSWord/win32
	rm -rf "${WORKDIR}"/ZAAPlugins/PDF/win32
	zproduct_src_install
}
