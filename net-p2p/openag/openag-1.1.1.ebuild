# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-p2p/openag/openag-1.1.1.ebuild,v 1.2 2002/06/25 11:12:27 bangert Exp $

MY_P=OpenAG-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An open source command line client for the AudioGalaxy (TM) music sharing protocol"
SRC_URI="mirror://sourceforge/openags/${MY_P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/openags"
SLOT="0"

DEPEND="media-libs/libmpeg3"

src_install() {

	make DESTDIR=${D} install

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
