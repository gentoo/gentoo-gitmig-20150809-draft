# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/tedia2sql/tedia2sql-1.2.8.ebuild,v 1.3 2004/04/07 19:02:06 vapier Exp $

inherit eutils

MY_PV=${PV//.}
DESCRIPTION="Convert database ERD designed in Dia into SQL DDL scripts."
HOMEPAGE="http://tedia2sql.tigris.org/"
SRC_URI="http://tedia2sql.tigris.org/files/documents/282/2144/${PN}-${MY_PV}.tar.gz"

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
	epatch ${FILESDIR}/${PN}-gentoo.patch
}

src_install() {
	insinto /etc
	doins tedia2sqlrc

	dobin tedia2sql
	dodoc README
	use doc && dohtml -A sql -A dia www/*
}
