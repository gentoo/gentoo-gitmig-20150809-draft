# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moosic/moosic-1.3.3.ebuild,v 1.1 2003/04/12 07:56:40 jje Exp $

DESCRIPTION="Moosic is a music player that focuses on easy playlist management"
HOMEPAGE="http://www.nanoo.org/~daniel/moosic/"
SRC_URI="http://www.nanoo.org/~daniel/moosic/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/python"
S=${WORKDIR}/${P}

src_compile() {
	make manpages
}

src_install() {
	make install INSTALL_PREFIX=$D/usr

	dodoc ChangeLog History Moosic_Client_API.txt README Todo
}
