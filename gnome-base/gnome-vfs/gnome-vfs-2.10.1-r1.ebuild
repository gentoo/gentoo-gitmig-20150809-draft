# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-2.10.1-r1.ebuild,v 1.8 2005/08/08 14:42:41 corsair Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Virtual Filesystem"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="2"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="doc ssl gnutls samba ipv6 hal howl"

RDEPEND=">=dev-libs/glib-2.6
	>=gnome-base/gconf-1.2
	>=gnome-base/orbit-2.9
	>=gnome-base/libbonobo-2
	>=dev-libs/libxml2-2.6
	app-arch/bzip2
	dev-libs/popt

	virtual/fam

	gnome-base/gnome-mime-data
	>=x11-misc/shared-mime-info-0.16

	ssl? ( >=dev-libs/openssl-0.9.5
		!gnome-extra/gnome-vfs-sftp )
	gnutls? ( !ssl? ( net-libs/gnutls
			!gnome-extra/gnome-vfs-sftp ) )
	samba? ( >=net-fs/samba-3
		!gnome-extra/gnome-vfs-extras )
	hal? ( >=sys-apps/hal-0.4
		>=sys-apps/dbus-0.22 )
	howl? ( >=net-misc/howl-0.9.6-r1 )"

# ssl/gnutls USE deps : if both are enabled choose openssl
# foser <foser@gentoo.org> 19 Apr 2004

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

G2CONF="${G2CONF} \
	$(use_enable ssl openssl) \
	$(use_enable gnutls) \
	$(use_enable samba) \
	$(use_enable ipv6) \
	$(use_enable hal) \
	$(use_enable howl) \
	--disable-schemas-install
	--without-gtk"

# this works because of the order of conifgure parsing
# so should always be behind the use_enable options
# foser <foser@gentoo.org 19 Apr 2004
use gnutls && use ssl && G2CONF="${G2CONF} --disable-gnutls"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

USE_DESTDIR="1"

src_unpack() {

	unpack ${A}
	cd ${S}

	# reiser4 patch, c'mon (#57756)
	epatch ${FILESDIR}/${PN}-2.8.3-reiser4_support.patch
	# CAN-2005-0706 (#84936)
	epatch ${FILESDIR}/${PN}-2-CAN-2005-0706.patch
	# fix timestamp issues (#92740)
	epatch ${FILESDIR}/${P}-date_time_stamp.patch

}

src_install() {

	gnome2_src_install

	# remove unused dir (#46567)
	rmdir ${D}/usr/doc

}
