# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gnome-system-tools/gnome-system-tools-2.22.2.ebuild,v 1.1 2009/04/09 22:16:26 eva Exp $

inherit autotools eutils gnome2

DESCRIPTION="Tools aimed to make easy the administration of UNIX systems"
HOMEPAGE="http://www.gnome.org/projects/gst/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nfs policykit samba"

RDEPEND="
	>=dev-libs/liboobs-2.21.3
	>=x11-libs/gtk+-2.11.3
	>=dev-libs/glib-2.15.2
	>=gnome-base/gconf-2.2
	dev-libs/dbus-glib
	>=gnome-base/nautilus-2.9.90
	sys-libs/cracklib
	nfs? ( net-fs/nfs-utils )
	samba? ( >=net-fs/samba-3 )
	policykit? ( >=sys-auth/policykit-0.5 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.3.2
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.0"

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable policykit polkit)"

	if ! use nfs && ! use samba; then
		G2CONF="${G2CONF} --disable-shares"
	fi

	if use policykit && ! built_with_use app-admin/system-tools-backends policykit; then
		eerror "app-admin/system-tools-backends was not built with USE='policykit'"
		die "Please rebuild app-admin/system-tools-backends with policykit support"
	fi
}

src_unpack() {
	gnome2_src_unpack

	# Fix automagic policykit detection
	epatch "${FILESDIR}/${P}-automagic-polkit.patch"

	# Add more services to the list
	epatch "${FILESDIR}/${P}-more-services.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}
