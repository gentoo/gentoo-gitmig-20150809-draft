# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-2.14.1.ebuild,v 1.1 2006/05/01 18:25:57 dang Exp $

inherit eutils gnome2

DESCRIPTION="Gnome Virtual Filesystem"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="avahi doc gnutls hal ipv6 samba ssl"

RDEPEND=">=gnome-base/libbonobo-2.3.1
	>=gnome-base/gconf-1.2
	>=dev-libs/glib-2.9.3
	>=gnome-base/orbit-2.12.4
	>=dev-libs/libxml2-2.6
	>=net-misc/neon-0.25.3
	app-arch/bzip2
	virtual/fam
	gnome-base/gnome-mime-data
	>=x11-misc/shared-mime-info-0.14
	dev-libs/popt
	samba? ( >=net-fs/samba-3 )
	ssl? (
		>=dev-libs/openssl-0.9.5
		!gnome-extra/gnome-vfs-sftp )
	gnutls? (
		!ssl? (
			net-libs/gnutls
			!gnome-extra/gnome-vfs-sftp ) )
	hal? (
		>=sys-apps/hal-0.5.7
		>=sys-apps/dbus-0.32 )
	avahi? ( >=net-dns/avahi-0.6 )"

# ssl/gnutls USE deps : if both are enabled choose openssl
# foser <foser@gentoo.org> 19 Apr 2004

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

pkg_setup() {
	G2CONF="--disable-schemas-install \
		--disable-howl			  \
		--enable-http-neon        \
		$(use_enable ssl openssl) \
		$(use_enable gnutls)      \
		$(use_enable samba)       \
		$(use_enable ipv6)        \
		$(use_enable hal)         \
		$(use_enable avahi)"

	# this works because of the order of conifgure parsing
	# so should always be behind the use_enable options
	# foser <foser@gentoo.org 19 Apr 2004
	use gnutls && use ssl && G2CONF="${G2CONF} --disable-gnutls"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Allow the Trash on afs filesystems (#106118)
	epatch ${FILESDIR}/${PN}-2.12.0-afs.patch
}
