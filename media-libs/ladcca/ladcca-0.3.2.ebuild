# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ladcca/ladcca-0.3.2.ebuild,v 1.4 2004/04/16 05:56:57 lv Exp $

DESCRIPTION="Linux Audio Developer's Configuration and Connection API (LADCCA)"
HOMEPAGE="http://pkl.net/~node/ladcca.html"
SRC_URI="http://pkl.net/~node/software/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="media-libs/alsa-lib \
	virtual/jack \
	>=x11-libs/gtk+-2.0"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
