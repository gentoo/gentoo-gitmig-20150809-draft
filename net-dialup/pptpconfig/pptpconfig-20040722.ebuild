# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpconfig/pptpconfig-20040722.ebuild,v 1.2 2004/11/07 13:09:40 mrness Exp $

DESCRIPTION="Configuration and management program for PPTP Client tunnels"
HOMEPAGE="http://pptpclient.sourceforge.net/"
SRC_URI="mirror://sourceforge/pptpclient/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="dev-php/php-gtk
	net-dialup/pptpclient
	sys-apps/iproute2"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog DEVELOPERS NEWS README TODO
	dosed 's:/usr/lib/php-pcntl/bin/php:/usr/bin/php:g' /usr/bin/pptpconfig.php || die
}
