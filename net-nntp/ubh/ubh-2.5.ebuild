# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/ubh/ubh-2.5.ebuild,v 1.2 2005/05/16 16:43:50 swegener Exp $

DESCRIPTION="The Usenet Binary Harvester"
HOMEPAGE="http://ubh.sourceforge.net/"
SRC_URI="http://ubh.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
DEPEND=">=dev-perl/libnet-1.0607
	>=dev-perl/News-Newsrc-1.07
	>=dev-perl/IO-stringy-1.220
	>=dev-perl/MIME-Base64-2.12
	>=dev-perl/MailTools-1.15
	>=dev-perl/MIME-tools-5.411
	>=dev-perl/string-crc32-1.2"

src_install() {
	dobin ubh || die "dobin failed"
	dohtml doc/ubh.html || die "dohtml failed"
	insinto /usr/share/${P}
	doins examples/{newsrc,ubhrc} || die "doins failed"
}
