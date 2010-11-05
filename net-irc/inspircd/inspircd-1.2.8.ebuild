# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/inspircd/inspircd-1.2.8.ebuild,v 1.1 2010/11/05 11:37:38 fauli Exp $

EAPI=2
inherit eutils toolchain-funcs multilib

DESCRIPTION="InspIRCd - The Modular C++ IRC Daemon"
HOMEPAGE="http://www.inspircd.org/"
SRC_URI="http://www.inspircd.org/downloads/InspIRCd-${PV}.tar.bz2
	mirror://sourceforge/${PN}/InspIRCd-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="openssl gnutls ipv6 mysql postgres sqlite zlib ldap"

RDEPEND="
	dev-lang/perl
	openssl? ( dev-libs/openssl )
	gnutls? ( net-libs/gnutls )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )
	sqlite? ( >=dev-db/sqlite-3.0 )
	ldap? ( net-nds/openldap )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/inspircd"

src_prepare() {
	local SQL=0
	cd src/modules || die

	if use zlib ; then
		cp extra/m_ziplink.cpp . || die
	fi

	if use openssl ; then
		cp extra/m_ssl_openssl.cpp . || die
	fi

	if use gnutls ; then
		cp extra/m_ssl_gnutls.cpp . || die
	fi

	if use ldap ; then
		cp extra/m_ldapauth.cpp . || die
	fi

	if use mysql ; then
		SQL=1
		cp extra/m_mysql.cpp . || die
	fi
	if use postgres ; then
		SQL=1
		cp extra/m_pgsql.cpp . || die
	fi
	if use sqlite ; then
		SQL=1
		cp extra/m_sqlite3.cpp . || die
	fi
	if [ ${SQL} -eq 1 ] ; then
		cp extra/m_sql{auth.cpp,log.cpp,oper.cpp,utils.cpp,utils.h,v2.h} . || die
	fi
}

src_configure() {
	# ./configure doesn't know --disable-gnutls, -ipv6 and -openssl options,
	# so should be used only --enable-like.
	local myconf=""
	use gnutls  && myconf="--enable-gnutls"
	use ipv6  && myconf="${myconf} --enable-ipv6 --enable-remote-ipv6"
	use openssl && myconf="${myconf} --enable-openssl"

	# allow inspircd to be built by root
	touch .force-root-ok || die

	./configure ${myconf} \
		--enable-epoll \
		--prefix="/usr/$(get_libdir)/inspircd" \
		--config-dir="/etc/inspircd" \
		--binary-dir="/usr/bin" \
		--library-dir="/usr/$(get_libdir)/inspircd" \
		--module-dir="/usr/$(get_libdir)/inspircd/modules" \
		|| die "configure failed"
	./configure -modupdate || die "modupdate failed"
}

src_compile() {
	emake CC="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	# the inspircd buildsystem does not create these, its configure script
	# does. so, we have to make sure they are there.
	dodir /usr/$(get_libdir)/inspircd || die
	dodir /usr/$(get_libdir)/inspircd/modules || die
	dodir /etc/inspircd || die
	dodir /var/log/inspircd || die
	dodir /usr/include/inspircd || die

	emake install \
		LIBPATH="${D}/usr/$(get_libdir)/inspircd/" \
		MODPATH="${D}/usr/$(get_libdir)/inspircd/modules/" \
		CONPATH="${D}/etc/inspircd" \
		BINPATH="${D}/usr/bin" \
		BASE="${D}/usr/$(get_libdir)/inspircd/inspircd.launcher" || die

	insinto /usr/include/inspircd/
	doins include/* || die

	newinitd "${FILESDIR}"/init.d_inspircd inspircd || die

	keepdir "/var/log/inspircd/"
}

pkg_postinst() {
	enewgroup inspircd
	enewuser inspircd -1 -1 -1 inspircd
	chown -R inspircd:inspircd "${ROOT}"/etc/inspircd
	chmod 700 "${ROOT}"/etc/inspircd

	chmod 750 "${ROOT}"/var/log/inspircd
	chown -R inspircd:inspircd "${ROOT}"/var/log/inspircd

	chown -R inspircd:inspircd "${ROOT}"/usr/$(get_libdir)/inspircd
	chmod -R 755 "${ROOT}"/usr/$(get_libdir)/inspircd

	chmod -R 755 "${ROOT}"/usr/bin/inspircd
}
