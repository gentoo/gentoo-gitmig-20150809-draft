# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/quotient/quotient-0.9.1.ebuild,v 1.6 2004/07/19 22:10:00 kloeri Exp $

inherit distutils

MY_PN="Quotient"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Quotient is an open source product that combines a multi-protocol messaging server with tools for information management and retrieval. Quotient brings together your email, IM/IRC and IP telephony."
HOMEPAGE="http://www.divmod.org/Home/Projects/Quotient/"
SRC_URI="http://www.divmod.org/users/release/divmod/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-python/twisted-1.3.0
	>=mail-filter/spambayes-1.0_rc1
	>=dev-python/imaging-1.1.4
	>=dev-python/lupy-0.2.1
	>=dev-python/nevow-0.2.0"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install
	dodoc doc/* || die "doc/* failed"
	#dobin bin/* || die "bin/* failed" ---> conflict with "porthole"
	insinto /usr/share/doc/${P}/bin || die "bin failed"
	doins bin/* || die "bin/* failed"
	insinto /usr/share/doc/${P}/tools || die "tools failed"
	doins tools/* || die "tools/* failed"
	insinto /usr/share/doc/${P}/tools/agi || die "tools/agi failed"
	doins tools/agi/* || die "tools/agi/* failed"
	insinto /usr/share/doc/${P}/admin || die "admin failed"
	doins admin/* || die "admin/* failed"
}
