# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/am-utils/am-utils-6.1.3.ebuild,v 1.5 2006/04/08 13:13:03 blubb Exp $

inherit eutils

DESCRIPTION="amd automounter and utilities"
HOMEPAGE="http://www.am-utils.org/"
SRC_URI="ftp://ftp.am-utils.org/pub/am-utils/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc x86"
IUSE="ldap"

RDEPEND="ldap? ( >=net-nds/openldap-1.2 )"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

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
