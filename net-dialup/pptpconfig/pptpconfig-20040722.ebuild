# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpconfig/pptpconfig-20040722.ebuild,v 1.4 2005/02/12 09:33:17 mrness Exp $

DESCRIPTION="Configuration and management program for PPTP Client tunnels"
HOMEPAGE="http://pptpclient.sourceforge.net/"
SRC_URI="mirror://sourceforge/pptpclient/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
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
