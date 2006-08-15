# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-super-smack/mysql-super-smack-1.3.ebuild,v 1.3 2006/08/15 21:34:13 malc Exp $

inherit eutils

MY_PN="super-smack"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="MySQL Super Smack is a benchmarking, stress testing, and load generation tool for MySQL & PostGreSQL"
HOMEPAGE="http://vegan.net/tony/supersmack/"
SRC_URI="http://vegan.net/tony/supersmack/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mysql postgres"

DEPEND="mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use !mysql && use !postgres && die "You need to use at least one of USE=mysql or USE=postgres for benchmarking!"
}

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-1.2.destdir.patch
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.3.amd64.patch
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
