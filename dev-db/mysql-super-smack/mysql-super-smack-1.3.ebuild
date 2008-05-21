# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-super-smack/mysql-super-smack-1.3.ebuild,v 1.7 2008/05/21 15:55:31 dev-zero Exp $

WANT_AUTOMAKE="1.4"

inherit eutils autotools

MY_PN="super-smack"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="MySQL Super Smack is a benchmarking, stress testing, and load generation tool for MySQL & PostGreSQL."
HOMEPAGE="http://vegan.net/tony/supersmack/"
SRC_URI="http://vegan.net/tony/supersmack/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mysql postgres"

DEPEND="mysql? ( virtual/mysql )
		postgres? ( virtual/postgresql-server )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use !mysql && use !postgres && die "You need to use at least one of USE=mysql or USE=postgres for benchmarking!"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-1.2.destdir.patch"
	epatch "${FILESDIR}/${PN}-1.3.amd64.patch"

	eautomake || die "eautomake failed"
}

src_compile() {
	local myconf=""
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-pgsql"
	myconf="${myconf} --with-datadir=/var/tmp/${MY_PN}"
	myconf="${myconf} --with-smacks-dir=/usr/share/${MY_PN}"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES INSTALL MANUAL README TUTORIAL
}
