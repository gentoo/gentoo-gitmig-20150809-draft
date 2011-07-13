# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/dymo-cups-drivers/dymo-cups-drivers-1.2.0.ebuild,v 1.1 2011/07/13 18:04:02 flameeyes Exp $

EAPI=4

DESCRIPTION="Dymo SDK for LabelWriter/LabelManager printers"
HOMEPAGE="http://sites.dymo.com/DeveloperProgram/Pages/LW_SDK_Linux.aspx"
SRC_URI="http://download.dymo.com/Download%20Drivers/Linux/Download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64"

RDEPEND="net-print/cups"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install

	dodoc AUTHORS README ChangeLog
	insinto /usr/share/doc/${PF}
	doins docs/*.{txt,rtf,ps,png} docs/SAMPLES
}
