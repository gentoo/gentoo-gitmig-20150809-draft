# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xine-dmd/xine-dmd-1.0.6.ebuild,v 1.2 2002/12/12 09:30:46 agenkin Exp $

S=${WORKDIR}/${PN/-/_}_plugin-${PV}
DESCRIPTION="DMD plugin for DVD playback for Xine player."
HOMEPAGE="http://www.geocities.com/xinedvdplugin/"
SRC_URI="http://www.geocities.com/xinedvdplugin/${PN/-/_}_plugin-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=media-libs/xine-lib-0.9*"

src_compile () {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
