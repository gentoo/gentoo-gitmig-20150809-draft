# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-2.6.0.ebuild,v 1.13 2004/11/08 15:06:47 vapier Exp $

# FIXME : can use gnutls
inherit gnome2 eutils

DESCRIPTION="Gnome Virtual Filesystem"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="2"
KEYWORDS="arm x86 ppc alpha ~sparc hppa amd64 mips ia64"
IUSE="doc ssl samba ipv6"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-1.2
	>=gnome-base/orbit-2.9
	>=gnome-base/libbonobo-2
	>=dev-libs/libxml2-2.2.8

	gnome-base/gnome-mime-data
	>=x11-misc/shared-mime-info-0.14

	app-admin/fam
	ssl? ( >=dev-libs/openssl-0.9.5
		!gnome-extra/gnome-vfs-sftp )
	samba? ( >=net-fs/samba-3
		!gnome-extra/gnome-vfs-extras )"

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

DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README TODO"

src_install() {

	gnome2_src_install

	# FIXME: there are cleaner ways to do this
	echo "trash:    libvfolder-desktop" >> ${D}/etc/gnome-vfs-2.0/modules/default-modules.conf

}

# Fix bonobo 
USE_DESTDIR="1"
