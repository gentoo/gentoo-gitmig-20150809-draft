# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moosic/moosic-1.5.0.ebuild,v 1.7 2007/07/11 19:30:23 mr_bones_ Exp $

DESCRIPTION="Moosic is a music player that focuses on easy playlist management"
HOMEPAGE="http://www.nanoo.org/~daniel/moosic/"
SRC_URI="http://www.nanoo.org/~daniel/moosic/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64"
IUSE=""
DEPEND="virtual/python"

src_install() {
	make install INSTALL_PREFIX=$D/usr

	insinto /etc/bash_completion.d/
	newins bash_completion moosic
	dodoc ChangeLog History Moosic_Client_API.txt README Todo
}
