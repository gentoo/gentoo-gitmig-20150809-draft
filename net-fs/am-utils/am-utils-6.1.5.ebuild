# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/am-utils/am-utils-6.1.5.ebuild,v 1.1 2008/04/01 17:54:22 rbu Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

DESCRIPTION="amd automounter and utilities"
HOMEPAGE="http://www.am-utils.org/"
SRC_URI="ftp://ftp.am-utils.org/pub/am-utils/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86 ~x86-fbsd"
IUSE="ldap"

RDEPEND="ldap? ( >=net-nds/openldap-1.2 )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-6.1.4-dbm_open-libc.patch"
	epatch "${FILESDIR}/${P}-uts_release.patch" #190842
	epatch "${FILESDIR}/${P}-CVE-2008-1078.patch" #210158
	eautoreconf
}

src_compile() {
	econf \
		$(use_with ldap) \
		--sysconfdir=/etc/amd \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	insinto /etc/amd
	doins "${FILESDIR}"/amd.{conf,net}
	newinitd "${FILESDIR}/amd.rc" amd
}
