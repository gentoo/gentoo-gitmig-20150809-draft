# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udisks/udisks-1.0.0.ebuild,v 1.3 2010/04/08 09:04:32 ssuominen Exp $

EAPI=3
inherit bash-completion

DESCRIPTION="Daemon providing interfaces to work with storage devices"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/DeviceKit"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug doc nls zeroconf"

COMMON_DEPEND=">=sys-fs/udev-147[extras]
	>=dev-libs/glib-2.16.1:2
	>=sys-apps/dbus-1
	>=dev-libs/dbus-glib-0.82
	>=sys-auth/polkit-0.92
	>=sys-apps/parted-1.8.8[device-mapper]
	>=sys-fs/lvm2-2.02.61
	>=dev-libs/libatasmart-0.14
	>=sys-apps/sg3_utils-1.27.20090411
	!sys-apps/devicekit-disks"
RDEPEND="${COMMON_DEPEND}
	zeroconf? ( net-dns/avahi )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	doc? ( dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2 )
	nls? ( >=dev-util/intltool-0.40.0 )"

src_configure() {
	econf \
		--localstatedir="${EPREFIX}/var" \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable debug verbose-mode) \
		--enable-man-pages \
		$(use_enable doc gtk-doc) \
		$(use_enable zeroconf remote-access) \
		$(use_enable nls) \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS HACKING NEWS README

	rm -f "${D}"/etc/profile.d/udisks-bash-completion.sh
	dobashcompletion tools/udisks-bash-completion.sh ${PN}

	find "${ED}" -name '*.la' -delete
}
