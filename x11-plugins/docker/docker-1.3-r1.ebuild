# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/docker/docker-1.3-r1.ebuild,v 1.1 2004/02/07 04:30:15 port001 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Openbox app which acts as a system tray for KDE and GNOME2"
SRC_URI="http://icculus.org/openbox/docker/${P}.tar.gz"
HOMEPAGE="http://icculus.org/openbox/docker/"

DEPEND=">=dev-libs/glib-2.0.4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

src_compile() {

	emake || die

}

src_install () {

	dobin docker
	dodoc COPYING README
}
