# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/chillispot/chillispot-0.99.ebuild,v 1.1 2005/01/12 21:12:24 solar Exp $

inherit eutils flag-o-matic gnuconfig

DESCRIPTION="ChilliSpot is an open source captive portal or wireless LAN access point controller."
HOMEPAGE="http://www.chillispot.org"
SRC_URI="http://www.chillispot.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sparc ~x86"
IUSE="pic"

DEPEND="virtual/libc >=sys-apps/sed-4*"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
	chmod 644 doc/*.conf
	find . -exec chmod go-w '{}' \;
}

src_compile() {
	local myconf
	export CFLAGS

	use pic && myconf="${myconf} --with-pic"

	econf ${myconf} || die "FAILED: econf ${myconf}"
	emake || die "FAILED: emake"
}

src_install() {
	einstall || die "einstall failed"
	cd doc && dodoc chilli.conf freeradius.users hotspotlogin.cgi firewall.iptables
}
