# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/balsa/balsa-2.3.26.ebuild,v 1.2 2009/01/09 17:15:05 ranger Exp $

inherit gnome2

DESCRIPTION="Email client for GNOME"
HOMEPAGE="http://balsa.gnome.org"
SRC_URI="http://balsa.gnome.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~sparc ~x86"
# Doesn't currently build with -gnome
IUSE="crypt doc gtkhtml gtkspell kerberos ldap libnotify rubrica sqlite ssl xface"

RDEPEND=">=dev-libs/glib-2.14
	>=x11-libs/gtk+-2.10
	=dev-libs/gmime-2.2*
	>=net-libs/libesmtp-1.0.3
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2.0
	x11-themes/hicolor-icon-theme
	net-mail/mailbase
	crypt? ( >=app-crypt/gpgme-1.0 )
	>=gnome-base/libgnome-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/gnome-vfs-2.0
	>=x11-libs/gtksourceview-2
	gtkhtml? ( >=gnome-extra/gtkhtml-3.14 )
	sqlite? ( >=dev-db/sqlite-2.8 )
	libnotify? ( x11-libs/libnotify )
	gtkspell? ( =app-text/gtkspell-2* )
	!gtkspell? ( virtual/aspell-dict )
	kerberos? ( app-crypt/mit-krb5 )
	ldap? ( net-nds/openldap )
	rubrica? ( dev-libs/libxml2 )
	ssl? ( dev-libs/openssl )
	xface? ( >=media-libs/compface-1.5.1 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	>=app-text/scrollkeeper-0.1.4
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO docs/*"

pkg_setup() {
	# threads are currently broken with gpgme
	G2CONF="${G2CONF} --disable-threads"

	if use crypt ; then
		G2CONF="${G2CONF} --with-gpgme=gpgme-config"
	else
		G2CONF="${G2CONF} --without-gpgme"
	fi

#	if use gnome ; then
		G2CONF="${G2CONF} --with-gtksourceview"
#	else
#		G2CONF="${G2CONF} --without-gtksourceview"
#	fi

	if use gtkhtml ; then
		G2CONF="${G2CONF} --with-gtkhtml=3"
	else
		G2CONF="${G2CONF} --without-gtkhtml"
	fi

	G2CONF="${G2CONF}
		--disable-pcre
		--enable-gregex
		--enable-threads
		$(use_with gtkspell)
		$(use_with kerberos gss)
		$(use_with ldap)
		$(use_with libnotify)
		$(use_with rubrica)
		$(use_with sqlite)
		$(use_with ssl)
		$(use_with xface compface)"
}

src_unpack() {
	gnome2_src_unpack

	# Remove disable deprecated statement
	sed -i -e '/DISABLE_DEPRECATED/d' \
		libinit_balsa/Makefile.am libinit_balsa/Makefile.in \
		libbalsa/Makefile.am libbalsa/Makefile.in \
		src/Makefile.am src/Makefile.in || die "sed failed"
}
