# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-super-smack/mysql-super-smack-1.2.ebuild,v 1.4 2004/07/20 03:14:55 robbat2 Exp $

inherit eutils

MY_PN="super-smack"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="MySQL Super Smack is a benchmarking, stress testing, and load generation tool for MySQL & PostGreSQL"
HOMEPAGE="http://jeremy.zawodny.com/mysql/${MY_PN}/"
SRC_URI="http://jeremy.zawodny.com/mysql/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mysql postgres"

DEPEND="mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	use !mysql && use !postgres && die "You need to use at least one of USE=mysql or USE=postgres for benchmarking!"
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.destdir.patch
	cd ${S}
	automake
}

src_compile() {
	local myconf
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-pgsql"
	myconf="${myconf} --with-datadir=/var/tmp/${MY_PN}"
	myconf="${myconf} --with-smacks-dir=/usr/share/${MY_PN}"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc CHANGES INSTALL MANUAL README TUTORIAL
}
