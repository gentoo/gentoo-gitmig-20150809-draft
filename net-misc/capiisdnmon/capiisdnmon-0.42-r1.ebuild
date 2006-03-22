# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/capiisdnmon/capiisdnmon-0.42-r1.ebuild,v 1.3 2006/03/22 19:40:34 genstef Exp $

inherit eutils flag-o-matic

DESCRIPTION="a CAPI 2.0 ISDN call monitor with LDAP name resolution"
HOMEPAGE="http://capiisdnmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/capiisdnmon/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="net-dialup/capi4k-utils
	net-nds/openldap
	x11-libs/xosd
	>=x11-libs/gtk+-2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# apply CAPI V3 patch conditionally
	grep 2>/dev/null -q CAPI_LIBRARY_V2 /usr/include/capiutils.h \
		&& epatch "${FILESDIR}"/${P}-capiv3.patch

	append-flags -DLDAP_DEPRECATED

	sed -i s/capiIsdnMon::// capiisdnmon.h
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	newicon icon1.xpm capiisdnmon.xpm
	make_desktop_entry capiIsdnMon "CAPI ISDN Monitor" capiisdnmon.xpm
}
