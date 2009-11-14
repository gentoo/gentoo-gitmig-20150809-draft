# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/ctdb/ctdb-9999.ebuild,v 1.2 2009/11/14 13:53:58 scarabeus Exp $

EGIT_REPO_URI="git://git.samba.org/tridge/ctdb.git"

inherit autotools eutils git

DESCRIPTION="A cluster implementation of the TDB database used by Samba and other projects to store temporary data."
HOMEPAGE="http://ctdb.samba.org/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/popt"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack

	epatch "${FILESDIR}/autoconf-2.62-fix.patch"

	rm -rf autom4te.cache
	rm -f configure config.h.in

	AT_M4DIR="-I ${S}/lib/replace -I ${S}/lib/talloc -I ${S}/lib/tdb -I ${S}/lib/popt -I ${S}/lib/events"
	autotools_run_tool autoheader ${AT_M4DIR} || die "running autoheader failed"
	eautoconf ${AT_M4DIR}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc "${D}/usr/share/doc/ctdb/README.eventscripts"
	rm -rf "${D}/usr/share/doc/ctdb"

	dohtml web/* doc/*.html
}
