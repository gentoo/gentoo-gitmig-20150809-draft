# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.33-r2.ebuild,v 1.7 2011/03/22 20:12:02 ranger Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit autotools eutils gnome2 flag-o-matic

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"

SRC_URI="${SRC_URI}
	mirror://gentoo/${PN}-patches-${PV}-r1.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="samba"

# FIXME: samba support is automatic
COMMON=">=x11-libs/gtk+-2.3.1:2
	>=dev-libs/glib-2.3.1:2
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.2.3
	gnome-base/gnome-keyring
	samba? ( net-fs/samba[smbclient] )"

RDEPEND="${COMMON}
	x11-libs/gksu"

DEPEND="${COMMON}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35"

pkg_setup() {
	DOCS="ChangeLog NEWS README"
	G2CONF="${G2CONF} --disable-static $(use_enable samba)"
}

src_prepare() {
	gnome2_src_prepare

	# Do not add CFLAGS to CPPFLAGS, bug #234028
	epatch "${FILESDIR}/${PN}-0.33-cxxflags-separation.patch"

	# Fix automagic samba support, bug #288392
	epatch "${FILESDIR}/${PN}-0.33-automagic-samba.patch"

	# Apply ubuntu patchset
	rm "${WORKDIR}"/patches/140_all_ui_tooltip.patch || \
		die "removing patch failed"
	export EPATCH_SOURCE="${WORKDIR}/patches" \
		EPATCH_SUFFIX="patch" \
		EPATCH_MULTI_MSG="Applying Ubuntu patches (enhancements) ..."
	epatch

	intltoolize --force --copy --automake || die
	eautoreconf
}

src_install() {
	gnome2_src_install
	# debian-specific.
	rm "${D}"/usr/sbin/gnome-cups-switch
}
