# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.8.2-r1.ebuild,v 1.1 2007/01/03 13:42:24 robbat2 Exp $

inherit gnome2 eutils autotools flag-o-matic

DESCRIPTION="gnome front end to gnupg"
HOMEPAGE="http://seahorse.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug gedit gnome ldap"

RDEPEND=">=gnome-base/libgnomeui-2.0
		 >=gnome-base/gnome-vfs-2.0
		 >=gnome-base/libglade-2.0
		 >=gnome-base/gconf-2.0
		 >=x11-libs/gtk+-2.4
		 >=dev-libs/glib-2.0
		 || ( =app-crypt/gnupg-1.4* >=app-crypt/gnupg-2.0.1-r2 )
		 >=app-crypt/gpgme-1.0.0
		 >=net-libs/libsoup-2.2
		   x11-misc/shared-mime-info
		 gedit? ( >=app-editors/gedit-2.8.0 )
		 gnome? (
					>=gnome-base/nautilus-2.10
					>=gnome-base/libbonobo-2
					>=gnome-base/libbonoboui-2
				)
		 ldap? ( net-nds/openldap )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/intltool-0.34
		>=dev-util/pkgconfig-0.19
		>=app-text/scrollkeeper-0.3"

DOCS="AUTHORS ChangeLog NEWS README TODO THANKS"

pkg_setup() {
	G2CONF="${G2CONF} --disable-update-mime-database \
			$(use_enable debug) \
			$(use_enable gedit) \
			$(use_enable gnome nautilus) \
			$(use_enable ldap)"
}

src_unpack() {
	gnome2_src_unpack
	epatch ${FILESDIR}/${PN}-0.8.2-gpg2.0.patch
}

src_compile() {
	append-ldflags $(bindnow-flags)
	gnome2_src_compile
}

src_install() {
	gnome2_src_install

	# remove conflicts with x11-misc/shared-mime-info
	rm -rf ${D}/usr/share/mime/application ${D}/usr/share/mime/magic \
		   ${D}/usr/share/mime/globs ${D}/usr/share/mime/XMLnamespaces
}
