# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpconfig/pptpconfig-20060222.ebuild,v 1.1 2006/03/16 20:02:51 mrness Exp $

DESCRIPTION="Configuration and management program for PPTP Client tunnels"
HOMEPAGE="http://pptpclient.sourceforge.net/"
SRC_URI="mirror://sourceforge/pptpclient/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( dev-php4/php-gtk dev-php/php-gtk )
	net-dialup/pptpclient
	sys-apps/iproute2"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog DEVELOPERS NEWS README TODO
	dosed 's:/usr/lib/php-pcntl/bin/php:/usr/bin/php:' /usr/bin/pptpconfig.php
}
