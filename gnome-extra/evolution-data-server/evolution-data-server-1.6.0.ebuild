# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-data-server/evolution-data-server-1.6.0.ebuild,v 1.3 2006/04/18 18:38:19 flameeyes Exp $

inherit eutils gnome2

DESCRIPTION="Evolution groupware backend"
HOMEPAGE="http://www.ximian.com/"

LICENSE="LGPL-2 Sleepycat"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc ipv6 kerberos krb4 ldap nntp ssl"

RDEPEND=">=dev-libs/glib-2.4
	>=gnome-base/libbonobo-2.4.2
	>=gnome-base/orbit-2.9.8
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=dev-libs/libxml2-2
	>=gnome-base/gconf-2
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=net-libs/libsoup-2.2
	sys-libs/zlib
	ldap? ( >=net-nds/openldap-2.0 )
	ssl? (
		>=dev-libs/nspr-4.4
		>=dev-libs/nss-3.9 )
	kerberos? ( virtual/krb5 )
	krb4? ( virtual/krb5 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	doc? ( >=dev-util/gtk-doc-1.4 )"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="ChangeLog MAINTAINERS NEWS TODO"

RESTRICT="confcache"

pkg_setup() {
	G2CONF="$(use_with ldap openldap) \
		$(use_with kerberos krb5 /usr) \
		$(use_enable ssl nss)          \
		$(use_enable ssl smime)        \
		$(use_enable ipv6)             \
		$(use_enable nntp)"

	if use krb4 && ! built_with_use virtual/krb5 krb4; then
		ewarn
		ewarn "In order to add kerberos 4 support, you have to emerge"
		ewarn "virtual/krb5 with the 'krb4' USE flag enabled as well."
		ewarn
		ewarn "Skipping for now."
		ewarn
		G2CONF="${G2CONF} --without-krb4"
	else
		G2CONF="${G2CONF} $(use_with krb4 krb4 /usr)"
	fi
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch ${FILESDIR}/${PN}-1.2.0-gentoo_etc_services.patch

	# Fix calandar crashing, bug #86174
	epatch "${FILESDIR}"/${PN}-1.4.2.1-calandar-crash-fix.patch

	# Resolve symbols at execution time for setgid binaries
	epatch "${FILESDIR}"/${PN}-no_lazy_bindings.patch

	sed -n -e '/GNOME_COMPILE_WARNINGS/,/dnl IT_PROG_INTLTOOL/p' \
		aclocal.m4 > gnome.m4
	export WANT_AUTOMAKE=1.9
	aclocal -I . || die "aclocal failed"
	automake || die "automake failed"
}

src_compile() {
	# Use NSS/NSPR only if 'ssl' is enabled.
	if use ssl ; then
		NSS_LIB=/usr/$(get_libdir)/nss
		NSS_INC=/usr/include/nss
		NSPR_LIB=/usr/$(get_libdir)/nspr
		NSPR_INC=/usr/include/nspr

		G2CONF="${G2CONF} \
			--with-nspr-includes=${NSPR_INC} \
			--with-nspr-libs=${NSPR_LIB}     \
			--with-nss-includes=${NSS_INC}   \
			--with-nss-libs=${NSS_LIB}"
	else
		G2CONF="${G2CONF} --without-nspr-libs --without-nspr-includes \
			--without-nss-libs --without-nss-includes"
	fi

	cd "${S}/libdb/dist"
	./s_config || die

	cd "${S}"
	gnome2_src_compile
}
