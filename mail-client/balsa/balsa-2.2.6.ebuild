# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/balsa/balsa-2.2.6.ebuild,v 1.1 2005/03/26 04:23:12 allanonjl Exp $

inherit gnome2 eutils

IUSE="doc ssl gtkhtml pcre ldap crypt kerberos threads sqlite"
DESCRIPTION="Email client for GNOME"
SRC_URI="http://balsa.gnome.org/${P}.tar.bz2"
HOMEPAGE="http://balsa.gnome.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND="net-mail/mailbase
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprintui-2.1.4
	>=net-libs/libesmtp-1.0-r1
	>=dev-libs/gmime-2.1.9
	sys-devel/libtool
	virtual/aspell-dict
	ssl? ( dev-libs/openssl )
	pcre? ( >=dev-libs/libpcre-3.4 )
	gtkhtml? ( =gnome-extra/libgtkhtml-2* )
	ldap? ( net-nds/openldap )
	kerberos? ( app-crypt/mit-krb5 )
	sqlite? ( >=dev-db/sqlite-2.8 )
	crypt? ( >=app-crypt/gpgme-0.9.0 )"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	app-text/scrollkeeper
	doc? ( dev-util/gtk-doc )
	"

USE_DESTDIR="1"

src_compile() {
	local myconf

	use crypt && myconf="${myconf} --with-gpgme=gpgme-config"

	econf \
		$(use_with ssl) \
		$(use_with ldap) \
		$(use_with sqlite) \
		$(use_with kerberos gss) \
		$(use_enable gtkhtml ) \
		$(use_enable threads ) \
		$(use_enable pcre ) \
		${myconf} || die "configure failed"

	emake || die "emake failed"
}

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO docs/*"
