# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/curl/curl-7.15.0.ebuild,v 1.1 2005/10/15 12:10:58 dragonheart Exp $

# NOTE: If you bump this ebuild, make sure you bump dev-python/pycurl!

inherit eutils

# NOTE: To prevent breakages when upgrading, we compile all the prev
#       versions we know. We can't slot them because only the libraries
#       have versioning, all the binaries, manpages don't have versions. 

OLD_PV=7.11.2
OLD_PV_LIB=libcurl.so.2

DESCRIPTION="A Client that groks URLs"
HOMEPAGE="http://curl.haxx.se/"
SRC_URI="http://curl.haxx.se/download/${PN}-${OLD_PV}.tar.bz2
		http://curl.haxx.se/download/${P}.tar.bz2"

LICENSE="MIT X11"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"
IUSE="ssl ipv6 ldap ares gnutls idn kerberos krb4 test"

RDEPEND="gnutls? ( net-libs/gnutls )
	ssl? ( !gnutls? ( dev-libs/openssl ) )
	ldap? ( net-nds/openldap )
	idn? ( net-dns/libidn )
	ares? ( net-dns/c-ares )
	kerberos? ( app-crypt/mit-krb5 )
	krb4? ( app-crypt/kth-krb )"

DEPEND="${RDEPEND}
	test? (
		net-misc/stunnel
		sys-apps/diffutils
		dev-lang/perl
	)"

_curl_has_old_ver() {
	if test -s ${ROOT}/usr/$(get_libdir)/${OLD_PV_LIB}; then
		return 0 # /bin/true
	else
		return 1
	fi
}

src_unpack() {
	unpack ${A}
	epunt_cxx
}

src_compile() {

	myconf="$(use_enable ldap)
		$(use_with idn libidn)
		$(use_with krb4)
		$(use_enable kerberos gssapi)
		$(use_enable ipv6)
		--enable-http
		--enable-ftp
		--enable-gopher
		--enable-file
		--enable-dict
		--enable-manual
		--enable-telnet
		--enable-nonblocking
		--enable-largefile"

	if use ipv6 && use ares; then
		ewarn "c-ares support disabled because it is incompatible with ipv6."
		ewarn "To enable ares support, emerge with USE='-ipv6'."
		myconf="${myconf} --disable-ares"
	else
		myconf="${myconf} $(use_enable ares)"
	fi

	if use ipv6 && use krb4; then
		ewarn "kerberos-4 support disabled because it is incompatible with ipv6."
		myconf="${myconf} --disable-krb4"
	else
		myconf="${myconf} $(use_enable krb4)"
	fi

	if use gnutls; then
		myconf="${myconf} --without-ssl --with-gnutls=/usr"
	elif use ssl; then
		myconf="${myconf} --without-gnutls --with-ssl=/usr"
	else
		myconf="${myconf} --without-gnutls --without-ssl"
	fi

	if _curl_has_old_ver; then
		einfo "Detected old version of curl - installing compat libs"
		cd ${WORKDIR}/${PN}-${OLD_PV}
		econf ${myconf}
		emake || die "make for old version failed"
	fi

	cd ${S}
	econf ${myconf}
	emake || die "install failed for current version"
}

src_install() {
	if _curl_has_old_ver; then
		cd ${WORKDIR}/${PN}-${OLD_PV}/lib
		make DESTDIR=${D} install-libLTLIBRARIES || die "install failed for old version"
	fi

	cd ${S}
	make DESTDIR="${D}" install || die "installed failed for current version"

	insinto /usr/share/aclocal
	doins docs/libcurl/libcurl.m4

	dodoc CHANGES README
	dodoc docs/FEATURES docs/INTERNALS docs/LIBCURL
	dodoc docs/MANUAL docs/FAQ docs/BUGS docs/CONTRIBUTE
}
