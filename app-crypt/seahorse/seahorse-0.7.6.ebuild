# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.7.6.ebuild,v 1.2 2005/03/25 23:17:24 vanquirius Exp $

inherit gnome2 eutils

DESCRIPTION="gnome front end to gnupg"
HOMEPAGE="http://seahorse.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~ppc64"

RDEPEND="virtual/x11
	>=app-crypt/gnupg-1.2.0
	>=app-crypt/gpgme-1.0.0
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2.4
	>=gnome-base/eel-2
	>=gnome-base/gnome-mime-data-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2
	>=app-editors/gedit-2.8.0
	dev-util/intltool
	dev-libs/glib
	x11-misc/shared-mime-info
	ldap? ( net-nds/openldap )"

#no ~ppc64 keyword yet 	>=gnome-base/bonobo-activation-2

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO THANKS"
IUSE="doc ldap"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-gnome-2.10.patch"
}

src_compile() {
	autoconf
	# note below doesn't work - need to fix
	append-ldflags -Wl,-z,now
	export LDFLAGS

	G2CONF=`use_enable ldap`
	gnome2_src_compile
}


src_install() {
	gnome2_src_install

	# remove conflicts with x11-misc/shared-mime-info
	rm -rf ${D}/usr/share/mime/application ${D}/usr/share/mime/magic ${D}/usr/share/mime/globs \
		${D}/usr/share/mime/XMLnamespaces
}
