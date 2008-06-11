# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dhcpdump/dhcpdump-1.7.ebuild,v 1.2 2008/06/11 07:44:49 bangert Exp $

DESCRIPTION="DHCP Packet Analyzer/tcpdump postprocessor"
HOMEPAGE="http://www.mavetju.org/unix/general.php"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install () {
	make DESTDIR="${D}" install || die
}
