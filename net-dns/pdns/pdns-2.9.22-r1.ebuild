# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/pdns/pdns-2.9.22-r1.ebuild,v 1.1 2009/07/06 20:00:15 ssuominen Exp $

EAPI="2"

inherit multilib eutils

DESCRIPTION="The PowerDNS Daemon"
SRC_URI="http://downloads.powerdns.com/releases/${P}.tar.gz"
HOMEPAGE="http://www.powerdns.com/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc ldap mysql postgres sqlite sqlite3 static opendbx"

DEPEND="mysql? ( virtual/mysql )
	postgres? ( >=dev-cpp/libpqpp-4.0-r1 )
	ldap? ( >=net-nds/openldap-2.0.27-r4 )
	sqlite? ( =dev-db/sqlite-2.8* )
	sqlite3? ( =dev-db/sqlite-3* )
	opendbx? ( dev-db/opendbx )
	>=dev-libs/boost-1.31"

RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )"

src_unpack() {
	default
	cd "${S}"
	epatch "${FILESDIR}"/2.9.18-default-mysql-options.patch \
		"${FILESDIR}"/${P}-gcc44.patch
}

src_configure() {
	local modules="pipe geo" myconf=""

	use mysql && modules="${modules} gmysql"
	use postgres && modules="${modules} gpgsql"
	use sqlite && modules="${modules} gsqlite"
	use sqlite3 && modules="${modules} gsqlite3"
	use opendbx && modules="${modules} opendbx"
	use ldap && modules="${modules} ldap"
	use debug && myconf="${myconf} --enable-verbose-logging"

	econf \
		--sysconfdir=/etc/powerdns \
		--libdir=/usr/$(get_libdir)/powerdns \
		--disable-recursor \
		--with-modules= \
		--with-dynmodules="${modules}" \
		--with-pgsql-includes=/usr/include \
		--with-pgsql-lib=/usr/$(get_libdir) \
		--with-mysql-lib=/usr/$(get_libdir) \
		--with-sqlite-lib=/usr/$(get_libdir) \
		--with-sqlite3-lib=/usr/$(get_libdir) \
		$(use_enable static static-binaries) \
		${myconf} \
		|| die "econf failed"
}

src_compile() {
	default

	if use doc
	then
		emake -C codedocs codedocs || die "emake codedocs failed"
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	mv "${D}"/etc/powerdns/pdns.conf{-dist,}

	# set defaults: setuid=pdns, setgid=pdns
	sed -i \
		-e 's/^# set\([ug]\)id=$/set\1id=pdns/g' \
		"${D}"/etc/powerdns/pdns.conf

	doinitd "${FILESDIR}"/pdns

	keepdir /var/empty

	dodoc ChangeLog README TODO
	use doc && dohtml -r codedocs/html/.

	# Install development headers
	insinto /usr/include/pdns
	doins pdns/*.hh
	insinto /usr/include/pdns/backends/gsql
	doins pdns/backends/gsql/*.hh
}

pkg_preinst() {
	enewgroup pdns
	enewuser pdns -1 -1 /var/empty pdns
}

pkg_postinst() {
	elog
	elog "PowerDNS provides multiple instances support. You can create more instances"
	elog "by symlinking the pdns init script to another name."
	elog
	elog "The name must be in the format pdns.<suffix> and PowerDNS will use the"
	elog "/etc/powerdns/pdns-<suffix>.conf configuration file instead of the default."
	elog
}
