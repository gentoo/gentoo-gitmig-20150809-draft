# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nat-traverse/nat-traverse-0.4.ebuild,v 1.1 2006/02/19 00:31:19 jokey Exp $

DESCRIPTION="Traverse NAT gateways with the Use of UDP"
HOMEPAGE="http://linide.sourceforge.net/nat-traverse/"
SRC_URI="http://linide.sourceforge.net/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1"

src_install() {
	doman nat-traverse.1
	dobin nat-traverse

	dodoc ChangeLog README
}

