# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.67.ebuild,v 1.7 2005/08/23 13:43:25 ka0ttic Exp $

inherit eutils flag-o-matic

DESCRIPTION="Flow-tools is a package for collecting and processing NetFlow data"
HOMEPAGE="http://www.splintered.net/sw/flow-tools/"
SRC_URI="ftp://ftp.eng.oar.net/pub/flow-tools/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mysql postgres debug"

RDEPEND="virtual/libc
	sys-apps/tcp-wrappers
	sys-libs/zlib
	sys-devel/flex
	!postgres? ( mysql? ( dev-db/mysql ) )
	!mysql? ( postgres? ( dev-db/postgresql ) )"

DEPEND="${RDEPEND}
	sys-devel/bison"

pkg_setup() {
	if use mysql && use postgres ; then
		echo
		eerror "The mysql and postgres USE flags are mutually exclusive."
		eerror "Please choose either USE=mysql or USE=postgres, but not both."
		die
	fi

	enewgroup flowtools
	enewuser flowtools -1 -1 /var/lib/flow-tools flowtools
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fix-configure.diff
	epatch ${FILESDIR}/${P}-gcc34.diff
	epatch ${FILESDIR}/${P}-fix-a-zillion-warnings.diff
	use debug || epatch ${FILESDIR}/${P}-nodebug.patch
	epatch ${FILESDIR}/${P}-memleak.patch
	epatch ${FILESDIR}/${P}-debug.patch

	sed -i "s|\(^.*CFLAGS=\).*$|\1-Wall|" \
		configure.in src/Makefile.am lib/Makefile.am || die "sed CFLAGS failed"
}

src_compile() {
	einfo "Running autoreconf"
	autoreconf -f -i || die "autoreconf failed"

	use mysql && append-flags "-L/usr/lib/mysql -I/usr/include/mysql"
	use postgres && append-flags "-L/usr/lib/postgres -I/usr/include/postgres"

	econf \
		--localstatedir=/etc/flow-tools \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		|| die "econf failed"

	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc COPYING ChangeLog README INSTALL SECURITY TODO

	keepdir /var/lib/flow-tools
}

pkg_postinst() {
	chown flowtools:flowtools /var/lib/flow-tools
	chmod 0750 /var/lib/flow-tools
}
