# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udisks/udisks-1.94.0.ebuild,v 1.1 2012/04/11 18:14:12 ssuominen Exp $

EAPI=4
inherit eutils bash-completion-r1 linux-info systemd

DESCRIPTION="Daemon providing interfaces to work with storage devices"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/udisks"
SRC_URI="http://udisks.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="debug doc +introspection"

COMMON_DEPEND=">=dev-libs/glib-2.32.0
	>=sys-auth/polkit-0.104-r1
	>=dev-libs/libatasmart-0.18
	|| ( >=sys-fs/udev-171-r1[gudev] <sys-fs/udev-171-r1[extras] )
	introspection? ( >=dev-libs/gobject-introspection-1.30 )"
RDEPEND="${COMMON_DEPEND}
	virtual/eject"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/gdbus-codegen
	dev-util/intltool
	dev-util/pkgconfig
	doc? (
		dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2
		)"

DOCS="AUTHORS HACKING NEWS README"

pkg_setup() {
	if use amd64 || use x86; then
		CONFIG_CHECK="~USB_SUSPEND ~!IDE"
		linux-info_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.x-ntfs-3g.patch
}

src_configure() {
	econf \
		--localstatedir="${EPREFIX}"/var \
		--disable-static \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_enable introspection) \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html \
		"$(systemd_with_unitdir)"
}

src_install() {
	default

	local htmldir=udisks2
	if [[ -d ${ED}/usr/share/doc/${PF}/html/${htmldir} ]]; then
		dosym /usr/share/doc/${PF}/html/${htmldir} /usr/share/gtk-doc/html/${htmldir}
	fi

	rm -rf "${ED}"/etc/bash_completion.d
	dobashcomp tools/udisksctl-bash-completion.sh

	find "${ED}" -type f -name '*.la' -exec rm -f {} +

	keepdir /media
	keepdir /var/lib/udisks2 #383091
}
