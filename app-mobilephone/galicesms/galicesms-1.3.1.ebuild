# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/galicesms/galicesms-1.3.1.ebuild,v 1.1 2006/07/15 15:01:58 mrness Exp $

DESCRIPTION="GTK2 GUI interface for sending SMS messages via Rosso Alice (Italian ADSL service)"
HOMEPAGE="http://www.marzocca.net/linux/galicesms.html"
SRC_URI="http://www.marzocca.net/linux/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-perl/gtk2-perl
	dev-perl/libwww-perl
	dev-perl/URI"

S="${WORKDIR}"

src_install() {
	dobin "${PN}"
}
