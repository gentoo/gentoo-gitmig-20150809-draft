# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pygresql/pygresql-3.6.1.ebuild,v 1.6 2005/04/01 03:54:20 agriffis Exp $

inherit eutils distutils

MY_P="PyGreSQL-${PV}"
DESCRIPTION="a Python interface for PostgreSQL database."
SRC_URI="ftp://ftp.druid.net/pub/distrib/${MY_P}.tgz"
HOMEPAGE="http://www.druid.net/pygresql/"
LICENSE="as-is"
DEPEND=">=dev-db/postgresql-7.3
	dev-lang/python"
KEYWORDS="x86 ~ppc sparc alpha ~amd64 ~hppa ia64 ~mips"
IUSE=""
SLOT="0"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

