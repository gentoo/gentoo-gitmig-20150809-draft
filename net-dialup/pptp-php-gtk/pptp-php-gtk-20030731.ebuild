# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptp-php-gtk/pptp-php-gtk-20030731.ebuild,v 1.1 2003/12/16 11:25:38 brandy Exp $

DESCRIPTION="Configuration and management program for PPTP Client tunnels"
HOMEPAGE="http://pptpclient.sourceforge.net/"
SRC_URI="mirror://sourceforge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-php/php-gtk
	net-dialup/pptpclient"

S=${WORKDIR}/${P}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING DEVELOPERS NEWS README TODO
}
