# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.31-r2.ebuild,v 1.14 2007/09/03 02:35:17 vapier Exp $

inherit eutils gnome2 flag-o-matic

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"

#
# Please ensure that gcc-3.4 is stable on the arch before moving this to stable.
#
SRC_URI="${SRC_URI}
	http://archive.ubuntu.com/ubuntu/pool/main/g/gnome-cups-manager/gnome-cups-manager_0.31-1.1ubuntu14.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

# See ChangeLog regarding libgnomeui
RDEPEND=">=x11-libs/gtk+-2.3.1
	>=dev-libs/glib-2.3.1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.2.0
	gnome-base/gnome-keyring
	x11-libs/gksu"

DEPEND=">=x11-libs/gtk+-2.3.1
	>=dev-libs/glib-2.3.1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.2.0
	gnome-base/gnome-keyring
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"

DOCS="ChangeLog NEWS README"

src_unpack() {
	gnome2_src_unpack
	# exclude ubuntu branding
	mkdir ${WORKDIR}/ubuntu
	cd ${WORKDIR}/ubuntu
	cp -r ${S}/{po,ChangeLog,gnome-cups-manager} .
	# Remove the ubuntu functions that require external
	# scripts fixing bug 147972 (removes LAN browsing detection)
	sed -i \
		-e '/^---.*ui_browse_share_ctl.patch/,/^---/{/^---.*ui_browse_share_ctl.patch/!d;}' \
	 	${WORKDIR}/gnome-cups-manager_0.31-1.1ubuntu14.diff
	epatch ${WORKDIR}/gnome-cups-manager_0.31-1.1ubuntu14.diff
	# gksudo does not always work
	sed -i "s:gksudo:gksu:" debian/patches/change-su-command.patch
	cd ${S}
	epatch ${WORKDIR}/ubuntu/debian/patches/*

	# bug 141929
	use amd64 && replace-flags -O* -O0
}

src_install() {
	gnome2_src_install
	cd ${WORKDIR}/ubuntu/debian
	doman gnome-cups-icon.1 gnome-cups-manager.1 gnome-cups-add.8
	domenu gnome-cups-icon.desktop gnome-cups-manager.desktop
}
