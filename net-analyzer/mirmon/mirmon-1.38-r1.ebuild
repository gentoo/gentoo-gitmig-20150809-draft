# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mirmon/mirmon-1.38-r1.ebuild,v 1.1 2009/10/29 02:26:36 darkside Exp $

inherit webapp eutils

DESCRIPTION="Monitor the status of mirrors"
HOMEPAGE="http://www.cs.uu.nl/people/henkp/mirmon/"
SRC_URI="http://www.cs.uu.nl/people/henkp/$PN/src/$P.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-lang/perl-5.8.5-r2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/0001-Add-rsync-monitoring-support-to-mirmon.patch" \
		"${FILESDIR}/0002-Add-ipv6-monitor-support-to-mirmon.patch"
}

src_install() {
	webapp_src_preinst

	for file in mirmon.html mirmon.txt; do
		dodoc ${file}
		rm -f ${file}
	done
	cp -R . "${D}"/${MY_HTDOCSDIR}

	webapp_src_install
}
