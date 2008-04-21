# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/nsvs/nsvs-20070407.ebuild,v 1.2 2008/04/21 11:16:09 chtekk Exp $

inherit eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="A MySQL database backend for the NSS databases."
HOMEPAGE="http://fssos.sourceforge.net/"
SRC_URI="http://gentoo.longitekk.com/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/mysql"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_setup() {
	enewgroup nsvsd
	enewuser nsvsd -1 -1 -1 nsvsd
}

src_compile() {
	econf --localstatedir=/var || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /etc
	doins sample/nsvsd/nsvsd.conf

	newinitd "${FILESDIR}/${PN}.init" nsvsd

	dodoc ChangeLog NEWS README TODO

	docinto sample
	dodoc sample/nsvsd/README
	dodoc sample/nsvsd/linux/*
}
