# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/balsa/balsa-2.0.10.ebuild,v 1.2 2003/04/30 06:38:17 aliz Exp $

inherit gnome2 eutils

IUSE="ssl gtkhtml perl ldap"
DESCRIPTION="Email client for GNOME"
SRC_URI="http://balsa.gnome.org/${P}.tar.bz2"
HOMEPAGE="http://balsa.gnome.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

RDEPEND="net-mail/mailbase
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=net-libs/libesmtp-0.8.11
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeprint-2.1.4
	>=gnome-base/libgnomeprintui-2.1.4
	virtual/aspell-dict
	ssl? ( dev-libs/openssl )
	perl? ( >=dev-libs/libpcre-3.4 )
	gtkhtml? ( >=gnome-extra/libgtkhtml-2 )
	ldap? ( net-nds/openldap )"

DEPEND="dev-util/pkgconfig
	sys-devel/gettext
	>=app-text/scrollkeeper-0.1.4
	${RDEPEND}"

src_compile() {
	local myconf
	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl" 
	use gtkhtml \
		&& myconf="${myconf} --enable-gtkhtml" \
		|| myconf="${myconf} --disable-gtkhtml"
	use perl \
		&& myconf="${myconf} --enable-pcre" \
		|| myconf="${myconf} --disable-pcre"
	use ldap \
		&& myconf="${myconf} --enable-ldap" \
		|| myconf="${myconf} --disable-ldap"

	libmutt/configure \
		--prefix=/usr \
		--host=${CHOST} \
		--with-mailpath=/var/mail || die "configure libmutt failed"

	# threads diabled because of 17079
	#myconf="${myconf} --enable-threads"
	myconf="${myconf} --disable-threads"

	econf ${myconf} || die "configure balsa failed"
	emake || die "emake failed"
}

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO docs/*"
