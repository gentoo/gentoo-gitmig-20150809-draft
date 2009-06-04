# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpi/acpi-1.4.ebuild,v 1.3 2009/06/04 19:12:50 fauli Exp $

EAPI=2

DESCRIPTION="Attempts to replicate the functionality of the 'old' apm command on ACPI systems."
HOMEPAGE="http://sourceforge.net/projects/acpiclient/"
SRC_URI="mirror://sourceforge/acpiclient/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_configure() {
	econf --disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS || die
}
