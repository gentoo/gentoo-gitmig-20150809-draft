# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/osmo/osmo-0.1.6.ebuild,v 1.1 2008/01/16 15:50:02 drac Exp $

inherit eutils

DESCRIPTION="a personal organizer which includes calendar, task manager and address book."
HOMEPAGE="http://clay.ll.pl/osmo"
SRC_URI="mirror://sourceforge/${PN}-pim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10
	dev-libs/libxml2
	dev-libs/libical"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TRANSLATORS
	make_desktop_entry ${PN} "${PN} - a personal organizer" ${PN} \
		"Office;Calendar;GTK"
}
