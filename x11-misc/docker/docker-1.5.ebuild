# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/docker/docker-1.5.ebuild,v 1.7 2003/10/30 15:48:39 tseng Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Openbox app which acts as a system tray for KDE and GNOME2"
SRC_URI="http://icculus.org/openbox/docker/${P}.tar.gz"
HOMEPAGE="http://icculus.org/openbox/docker/"

DEPEND=">=dev-libs/glib-2.0.4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

src_compile() {

	emake || die

}

src_install () {

	dobin docker
	dodoc COPYING README
}
