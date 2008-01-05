# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/collectl/collectl-2.4.1.ebuild,v 1.1 2008/01/05 22:29:16 vapier Exp $

DESCRIPTION="light-weight performance monitoring tool capable of reporting interactively as well as logging to disk"
HOMEPAGE="http://collectl.sourceforge.net/"
SRC_URI="mirror://sourceforge/collectl/${P}-src.tar.gz"

LICENSE="GPL-2 Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.8
	>=perl-core/Time-HiRes-1.97.07
	>=dev-perl/Archive-Zip-1.20
	sys-apps/ethtool
	sys-apps/pciutils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^require/s: ".*/: "/usr/share/${PN}/:' \
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
