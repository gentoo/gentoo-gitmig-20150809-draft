# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udisks/udisks-1.0.1-r1.ebuild,v 1.5 2010/07/25 16:39:28 klausman Exp $

EAPI=3
inherit eutils bash-completion

DESCRIPTION="Daemon providing interfaces to work with storage devices"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/udisks"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="debug doc nls remote-access"

COMMON_DEPEND=">=sys-fs/udev-147[extras]
	>=dev-libs/glib-2.16.1:2
	>=sys-apps/dbus-1
	>=dev-libs/dbus-glib-0.82
	>=sys-auth/polkit-0.92
	>=sys-apps/parted-1.8.8[device-mapper]
	>=sys-fs/lvm2-2.02.66
	>=dev-libs/libatasmart-0.14
	>=sys-apps/sg3_utils-1.27.20090411
	!sys-apps/devicekit-disks"
RDEPEND="${COMMON_DEPEND}
	remote-access? ( net-dns/avahi )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	doc? ( dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2 )
	nls? ( >=dev-util/intltool-0.40.0 )"

# This would require running dbus and also sudo.
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${P}-lvm2_api_support.patch
}

src_configure() {
	econf \
		--localstatedir="${EPREFIX}/var" \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable debug verbose-mode) \
		--enable-man-pages \
		$(use_enable doc gtk-doc) \
		$(use_enable remote-access) \
		$(use_enable nls) \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS HACKING NEWS README

	rm -f "${ED}"/etc/profile.d/udisks-bash-completion.sh
	dobashcompletion tools/udisks-bash-completion.sh ${PN}

	find "${ED}" -name '*.la' -delete
	keepdir /media
}
