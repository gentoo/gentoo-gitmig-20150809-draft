# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-2.5.91.ebuild,v 1.1 2004/03/19 01:13:18 foser Exp $

# FIXME : can use gnutls
inherit gnome2 eutils

IUSE="doc ssl samba ipv6"

SLOT="2"

DESCRIPTION="Gnome Virtual Filesystem"
HOMEPAGE="http://www.gnome.org/"

KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~mips"
LICENSE="GPL-2 LGPL-2"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-1.2
	>=gnome-base/ORBit2-2.9
	>=gnome-base/libbonobo-2
	>=dev-libs/libxml2-2.2.8

	gnome-base/gnome-mime-data
	x11-misc/shared-mime-info

	app-admin/fam
	ssl? ( >=dev-libs/openssl-0.9.5
		!gnome-extra/gnome-vfs-sftp )
	samba? ( >=net-fs/samba-3 )"
#	gnome-base/gnome-keyring

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

G2CONF="${G2CONF} \
	$(use_enable ssl openssl) \
	$(use_enable samba) \
	$(use_enable ipv6) \
	--disable-schemas-install
	--without-gtk"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README TODO"

src_install() {

	gnome2_src_install

	# FIXME: there are cleaner ways to do this
	echo "trash:    libvfolder-desktop" >> ${D}/etc/gnome-vfs-2.0/modules/default-modules.conf

}

# Fix bonobo 
USE_DESTDIR="1"
