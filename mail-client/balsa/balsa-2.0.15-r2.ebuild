# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/balsa/balsa-2.0.15-r2.ebuild,v 1.6 2004/12/04 17:38:26 slarti Exp $

inherit gnome2 eutils

IUSE="ssl gtkhtml perl ldap crypt"
DESCRIPTION="Email client for GNOME"
SRC_URI="http://balsa.gnome.org/${P}.tar.bz2"
HOMEPAGE="http://balsa.gnome.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~amd64"

RDEPEND="net-mail/mailbase
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeprint-2.1.4
	>=gnome-base/libgnomeprintui-2.1.4
	>=net-libs/libesmtp-0.8.11
	virtual/aspell-dict
	ssl? ( dev-libs/openssl )
	perl? ( >=dev-libs/libpcre-3.4 )
	gtkhtml? ( =gnome-extra/libgtkhtml-2* )
	ldap? ( net-nds/openldap )
	crypt? ( ~app-crypt/gpgme-0.3.14-r1 )
	crypt? ( sys-devel/autoconf )"

DEPEND="dev-util/pkgconfig
	>=app-text/scrollkeeper-0.1.4
	>=sys-apps/sed-4
	${RDEPEND}"

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/balsa-gtk+-2.4-deprecation-fix.patch
}

src_compile() {
	local myconf

	export GPGME_CONFIG=${ROOT}/usr/bin/gpgme3-config
	if [ -x ${ROOT}/usr/bin/gpg ];
	then
		export GPG_PATH=${ROOT}/usr/bin/gpg
	elif [ -x ${ROOT}/usr/bin/gpg2 ];
	then
		export GPG_PATH=${ROOT}/usr/bin/gpg2
	fi

	libmutt/configure \
		--prefix=/usr \
		--host=${CHOST} \
		--with-mailpath=/var/mail || die "configure libmutt failed"

	# threads diabled because of 17079
	econf \
		`use_with ssl` \
		`use_enable gtkhtml` \
		`use_enable perl pcre` \
		`use_with ldap` \
		`use_with crypt gpgme` \
		--disable-threads || die "configure balsa failed"

	emake || die "emake failed"
}

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO docs/*"
