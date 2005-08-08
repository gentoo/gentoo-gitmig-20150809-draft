# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/capiisdnmon/capiisdnmon-0.42.ebuild,v 1.3 2005/08/08 10:59:53 dholm Exp $

inherit eutils

DESCRIPTION="A Capi 2.0 Isdn CallMonitor with ldap name resolution"
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
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
