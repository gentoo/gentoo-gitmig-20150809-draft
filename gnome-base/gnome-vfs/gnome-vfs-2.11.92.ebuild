# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-2.11.92.ebuild,v 1.2 2005/08/25 23:24:43 flameeyes Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Virtual Filesystem"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc gnutls hal howl ipv6 samba ssl static"

RDEPEND=">=gnome-base/libbonobo-2.3.1
	>=gnome-base/gconf-1.2
	>=dev-libs/glib-2.6
	>=gnome-base/orbit-2.9
	>=dev-libs/libxml2-2.6
	app-arch/bzip2
	virtual/fam
	gnome-base/gnome-mime-data
	>=x11-misc/shared-mime-info-0.14
	dev-libs/popt
	samba? (
		>=net-fs/samba-3
		!gnome-extra/gnome-vfs-extras )
	ssl? (
		>=dev-libs/openssl-0.9.5
		!gnome-extra/gnome-vfs-sftp )
	gnutls? (
		!ssl? (
			net-libs/gnutls
			!gnome-extra/gnome-vfs-sftp ) )
	hal? (
		>=sys-apps/hal-0.5
		>=sys-apps/dbus-0.32 )
	howl? ( >=net-misc/howl-0.9.6-r1 )"

# ssl/gnutls USE deps : if both are enabled choose openssl
# foser <foser@gentoo.org> 19 Apr 2004

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_enable ssl openssl) $(use_enable gnutls) \
		$(use_enable static) $(use_enable samba) $(use_enable ipv6) \
		$(use_enable hal) $(use_enable howl) --disable-schemas-install"

	# this works because of the order of conifgure parsing
	# so should always be behind the use_enable options
	# foser <foser@gentoo.org 19 Apr 2004
	use gnutls && use ssl && G2CONF="${G2CONF} --disable-gnutls"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-fbsd.patch
}

src_install() {
	gnome2_src_install

	# remove unused dir (#46567)
	rmdir ${D}/usr/doc
}
