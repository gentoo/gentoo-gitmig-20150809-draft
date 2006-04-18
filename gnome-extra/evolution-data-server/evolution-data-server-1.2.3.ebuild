# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-data-server/evolution-data-server-1.2.3.ebuild,v 1.17 2006/04/18 18:38:19 flameeyes Exp $

inherit eutils gnome2

DESCRIPTION="Evolution groupware backend"
HOMEPAGE="http://www.ximian.com/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc64 sparc x86"
IUSE="doc ldap mozilla ssl ipv6 nntp kerberos"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/libbonobo-2.4.2
	>=gnome-base/orbit-2.9.8
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	>=dev-libs/libxml2-2
	>=net-libs/libsoup-2.2.3
	gnome-base/libgnomeui
	ldap? ( >=net-nds/openldap-2.0 )
	ssl? ( mozilla? ( www-client/mozilla )
		  !mozilla? ( >=dev-libs/nspr-4.4
				  >=dev-libs/nss-3.9 )
		   )
	kerberos? ( virtual/krb5 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.30
	doc? ( >=dev-util/gtk-doc-1 )"

G2CONF="${G2CONF} `use_with ldap openldap` \
		`use_enable ssl nss` \
		`use_enable ssl smime` \
		`use_enable ipv6` \
	    `use_enable nntp`"

MAKEOPTS="${MAKEOPTS} -j1"
USE_DESTDIR=1

RESTRICT="confcache"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2.0-gentoo_etc_services.patch
	# fix local mailfolders (#87043)
	epatch ${FILESDIR}/${PN}-1.2.1-local-provider.patch
	# upstream gcc4 fix
	epatch ${FILESDIR}/${PN}-1.2.3-gcc4.patch

}

src_compile() {

	cd ${S}/libdb/dist
	./s_config || die

	cd ${S}
	local myconf=""

	use kerberos \
		&& myconf="${myconf} --with-krb5=/usr" \
		|| myconf="${myconf} --without-krb5"

	# Use Mozilla's NSS/NSPR libs if 'mozilla' *and* 'ssl' in USE
	# Use standalone NSS/NSPR if only 'ssl' in USE
	# Openssl support doesn't work and has been disabled in cvs

	if use ssl ; then
		if  use mozilla ; then
			NSS_LIB=/usr/$(get_libdir)/mozilla
			NSPR_LIB=/usr/$(get_libdir)/mozilla
			NSS_INC=/usr/$(get_libdir)/mozilla/include/nss
			NSPR_INC=/usr/$(get_libdir)/mozilla/include/nspr
		else
			NSS_LIB=/usr/$(get_libdir)/nss
			NSPR_LIB=/usr/$(get_libdir)/nspr
			NSS_INC=/usr/include/nss
			NSPR_INC=/usr/include/nspr
		fi

		myconf="${myconf} --enable-nss=yes \
			--with-nspr-includes=${NSPR_INC} \
			--with-nspr-libs=${NSPR_LIB} \
			--with-nss-includes=${NSS_INC} \
			--with-nss-libs=${NSS_LIB}"
	else
		myconf="${myconf} --without-nspr-libs --without-nspr-includes \
		--without-nss-libs --without-nss-includes"
	fi

	gnome2_src_configure ${G2CONF} ${myconf}
	emake || die "compile failed"

}
