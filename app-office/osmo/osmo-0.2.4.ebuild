# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/osmo/osmo-0.2.4.ebuild,v 1.1 2009/03/01 18:25:43 patrick Exp $

DESCRIPTION="A personal organizer which includes calendar, task manager and address book."
HOMEPAGE="http://clay.ll.pl/osmo"
SRC_URI="mirror://sourceforge/${PN}-pim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt ical syncml"

RDEPEND=">=x11-libs/gtk+-2.10
	dev-libs/libxml2
	x11-libs/libnotify
	ical? ( >=dev-libs/libical-0.33 )
	crypt? ( dev-libs/libgringotts )
	syncml? ( app-pda/libsyncml )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	sed -i -e 's:Management:Management;:' "${S}"/osmo.desktop
}

src_compile() {
	econf $(use_with syncml libsyncml) \
		$(use_with crypt gringotts) \
		--disable-dependency-tracking \
		|| die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodir /usr/share/icons/hicolor/scalable/apps
	insinto /usr/share/icons/hicolor/scalable/apps
	doins osmo.svg
	dodoc AUTHORS ChangeLog README README.syncml TRANSLATORS
}
