# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/balsa/balsa-2.3.4-r1.ebuild,v 1.1 2005/07/07 02:14:00 allanonjl Exp $

inherit gnome2 eutils

IUSE="doc ssl gtkhtml gnome pcre ldap crypt kerberos threads sqlite"
DESCRIPTION="Email client for GNOME"
SRC_URI="http://balsa.gnome.org/${P}.tar.bz2"
HOMEPAGE="http://balsa.gnome.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

RDEPEND="
	gnome? (
		>=gnome-base/libgnome-2.0
		>=gnome-base/libgnomeui-2.0
		>=gnome-base/gnome-vfs-2.0
		>=gnome-base/libbonobo-2.0
		>=gnome-base/libgnomeprint-2.1.4
		>=gnome-base/libgnomeprintui-2.1.4
	)
	>=dev-libs/gmime-2.1.9
	>=x11-libs/gtk+-2
	net-mail/mailbase
	>=net-libs/libesmtp-1.0-r1
	sys-devel/libtool
	virtual/aspell-dict
	ssl? ( dev-libs/openssl )
	pcre? ( >=dev-libs/libpcre-3.4 )
	gtkhtml? (
		|| (
			=gnome-extra/libgtkhtml-3.6*
			=gnome-extra/libgtkhtml-3.2*
			=gnome-extra/libgtkhtml-3.0*
			=gnome-extra/libgtkhtml-2*
		)
	)
	ldap? ( net-nds/openldap )
	kerberos? ( app-crypt/mit-krb5 )
	sqlite? ( >=dev-db/sqlite-2.8 )
	crypt? ( >=app-crypt/gpgme-0.9.0 )
	"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	gnome? ( >=app-text/scrollkeeper-0.1.4 )
	doc? ( dev-util/gtk-doc )
	"

USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/balsa-2.3.4-icon-cache.patch
}

src_install() {
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
}

use crypt \
	&& G2CONF="${G2CONF} --with-gpgme=gpgme-config" \
	|| G2CONF="${G2CONF} --without-gpgme"

G2CONF="${G2CONF} \
		$(use_with ssl) \
		$(use_with ldap) \
		$(use_with sqlite) \
		$(use_with kerberos gss) \
		$(use_with gnome) \
		$(use_enable gtkhtml) \
		$(use_enable threads) \
		$(use_enable pcre) \
		"

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO docs/*"
