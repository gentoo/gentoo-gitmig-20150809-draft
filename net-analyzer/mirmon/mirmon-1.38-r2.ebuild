# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mirmon/mirmon-1.38-r2.ebuild,v 1.2 2010/03/09 23:30:32 darkside Exp $

inherit webapp eutils

DESCRIPTION="Monitor the status of mirrors"
HOMEPAGE="http://people.cs.uu.nl/henkp/mirmon/"
SRC_URI="http://people.cs.uu.nl/henkp/mirmon/src/$PN/src/$P.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-lang/perl-5.8.5-r2"
RDEPEND="${DEPEND}
	dev-perl/Socket6
	virtual/perl-File-Temp"

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
