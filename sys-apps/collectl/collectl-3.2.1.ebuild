# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/collectl/collectl-3.2.1.ebuild,v 1.1 2009/04/27 05:36:53 vapier Exp $

DESCRIPTION="light-weight performance monitoring tool capable of reporting interactively as well as logging to disk"
HOMEPAGE="http://collectl.sourceforge.net/"
SRC_URI="mirror://sourceforge/collectl/${P}.src.tar.gz"

LICENSE="GPL-2 Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.8
	virtual/perl-Time-HiRes
	>=dev-perl/Archive-Zip-1.20
	sys-apps/ethtool
	sys-apps/pciutils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^require.*formatit.ph\";/s: \".*/: \"/usr/share/${PN}/:" \
		collectl.pl || die
}

src_install() {
	newbin collectl.pl collectl || die
	insinto /usr/share/${PN}
	doins formatit.ph || die
	insinto /etc
	doins collectl.conf || die
	doman man1/* || die
	dodoc RELEASE-collectl
	dohtml FAQ-collectl.html
	newinitd "${FILESDIR}"/collectl.initd collectl
}
