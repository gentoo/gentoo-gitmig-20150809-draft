# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/balsa/balsa-2.3.13.ebuild,v 1.4 2006/12/24 00:48:46 dertobi123 Exp $

inherit gnome2 eutils autotools

DESCRIPTION="Email client for GNOME"
HOMEPAGE="http://balsa.gnome.org"
SRC_URI="http://balsa.gnome.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc sparc ~x86"
IUSE="crypt doc gnome gtkhtml gtkspell kerberos ldap pcre sqlite ssl xface"

RDEPEND=">=dev-libs/glib-2.0
		 >=x11-libs/gtk+-2.4
		 >=dev-libs/gmime-2.1.19
		 >=net-libs/libesmtp-1.0.3
		 >=gnome-base/orbit-2
		 >=gnome-base/libbonobo-2.0
		   x11-themes/hicolor-icon-theme
		   sys-devel/libtool
		   sys-devel/gettext
		   net-mail/mailbase
		crypt? ( >=app-crypt/gpgme-1.0 )
		gnome? (
				>=gnome-base/libgnome-2.0
				>=gnome-base/libgnomeui-2.0
				>=gnome-base/gnome-vfs-2.0
				>=gnome-base/libgnomeprint-2.1.4
				>=gnome-base/libgnomeprintui-2.1.4
				>=x11-libs/gtksourceview-1.6.1
			   )
		gtkhtml? ( =gnome-extra/gtkhtml-2* )
		gtkspell? ( =app-text/gtkspell-2* )
		!gtkspell? ( virtual/aspell-dict )
		kerberos? ( app-crypt/mit-krb5 )
		ldap? ( net-nds/openldap )
		pcre? ( >=dev-libs/libpcre-5.0 )
		sqlite? ( >=dev-db/sqlite-2.8 )
		ssl? ( dev-libs/openssl )
		xface? ( >=media-libs/compface-1.5.1 )"
DEPEND="${RDEPEND}
		dev-util/intltool
		dev-util/pkgconfig
		gnome? ( >=app-text/scrollkeeper-0.1.4 )
		doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO docs/*"
USE_DESTDIR="1"

pkg_setup() {
	# threads are currently broken with gpgme
	G2CONF="--disable-threads"

	if use xface ; then
		G2CONF="${G2CONF} --with-compface"
	else
		G2CONF="${G2CONF} --without-compface"
	fi

	if use crypt ; then
		G2CONF="${G2CONF} --with-gpgme=gpgme-config"
	else
		G2CONF="${G2CONF} --without-gpgme"
	fi

	if use gnome ; then
		G2CONF="${G2CONF} --with-gtksourceview"
	else
		G2CONF="${G2CONF} --without-gtksourceview"
	fi

	if use gtkhtml ; then
		G2CONF="${G2CONF} --with-gtkhtml=2"
	else
		G2CONF="${G2CONF} --without-gtkhtml"
	fi

	G2CONF="${G2CONF} 					\
			$(use_with gnome) 			\
			$(use_with gtkspell) 		\
			$(use_with kerberos gss) 	\
			$(use_with ldap) 			\
			$(use_enable pcre) 			\
			$(use_with sqlite) 			\
			$(use_with ssl)"
}

src_install() {
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
}
