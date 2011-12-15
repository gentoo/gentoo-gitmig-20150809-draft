# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openvpn/networkmanager-openvpn-0.8.2-r1.ebuild,v 1.4 2011/12/15 14:31:08 ago Exp $

EAPI="2"

inherit eutils gnome.org

# NetworkManager likes itself with capital letters
MY_PN=${PN/networkmanager/NetworkManager}

DESCRIPTION="NetworkManager OpenVPN plugin."
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"
SRC_URI="${SRC_URI//${PN}/${MY_PN}}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="gnome"

RDEPEND="
	>=net-misc/networkmanager-${PV}
	>=net-misc/openvpn-2.1_rc9
	>=dev-libs/dbus-glib-0.74
	gnome? (
		>=x11-libs/gtk+-2.6:2
		gnome-base/gconf:2
		gnome-base/gnome-keyring
		gnome-base/libglade:2.0
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

# FAIL: (tls-import-data) unexpected 'ca' secret value
RESTRICT="test"

src_prepare() {
	# Drop DEPRECATED flags, bug #385597
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		auth-dialog/Makefile.am auth-dialog/Makefile.in \
		common/Makefile.am common/Makefile.in \
		common-gnome/Makefile.am common-gnome/Makefile.in \
		properties/Makefile.am properties/Makefile.in \
		src/Makefile.am src/Makefile.in \
		configure.ac configure || die
}

src_configure() {
	ECONF="--disable-more-warnings
		$(use_with gnome)"

	econf ${ECONF}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
