# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/acdctl/acdctl-1.1.ebuild,v 1.5 2009/06/28 18:03:43 patrick Exp $

EAPI="2"

DESCRIPTION="Apple Cinema Display Control"
HOMEPAGE="http://www.technocage.com/~caskey/acdctl/"
SRC_URI="http://www.technocage.com/~caskey/acdctl/download/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc"
IUSE=""
DEPEND="dev-libs/libusb:0"

src_install() {
	dobin acdctl
	dodoc CHANGELOG README
}
