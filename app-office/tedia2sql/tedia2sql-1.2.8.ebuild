# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/tedia2sql/tedia2sql-1.2.8.ebuild,v 1.1 2004/01/14 21:43:11 rphillips Exp $

mypv=$(echo ${PV} | sed s/\\.//g)

DESCRIPTION="Convert database ERD designed in Dia into SQL DDL scripts."
HOMEPAGE="http://tedia2sql.tigris.org/"
SRC_URI="http://tedia2sql.tigris.org/files/documents/282/2144/${PN}-${mypv}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc"

DEPEND=">=dev-lang/perl-5.8
		>=dev-perl/XML-DOM-1.43
		>=dev-perl/Digest-MD5-2.24"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo.patch || die
}

src_install() {
	insinto /etc
	doins tedia2sqlrc

	dobin tedia2sql
	dodoc LICENSE README
	use doc && dohtml -A sql -A dia www/*
}
