# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamass-milter/spamass-milter-0.3.1-r5.ebuild,v 1.3 2012/06/05 00:06:47 zmedico Exp $

EAPI=4

inherit eutils user

IUSE=""

DESCRIPTION="A milter for SpamAssassin"
HOMEPAGE="http://savannah.nongnu.org/projects/spamass-milt/"
SRC_URI="http://savannah.nongnu.org/download/spamass-milt/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="|| ( mail-filter/libmilter mail-mta/sendmail )
	>=mail-filter/spamassassin-3.1.0"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup milter
	enewuser milter -1 -1 /var/lib/milter milter
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-header.patch
	epatch "${FILESDIR}"/${PN}-auth_users.patch
	epatch "${FILESDIR}"/${PN}-popen-r1.patch
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}"/spamass-milter.rc3 spamass-milter
	newconfd "${FILESDIR}"/spamass-milter.conf3 spamass-milter
	dodir /var/run/milter
	keepdir /var/run/milter
	fowners milter:milter /var/run/milter
	dodir /var/lib/milter
	keepdir /var/lib/milter
	fowners milter:milter /var/lib/milter

	dodoc AUTHORS NEWS README ChangeLog "${FILESDIR}/README.gentoo"
}

pkg_postinst() {
	elog "Documentation is installed in /usr/share/doc/${P}"
}
