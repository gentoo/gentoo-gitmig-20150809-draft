# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moosic/moosic-1.5.2.ebuild,v 1.1 2006/09/11 03:55:45 metalgod Exp $

DESCRIPTION="Moosic is a music player that focuses on easy playlist management"
HOMEPAGE="http://www.nanoo.org/~daniel/moosic/"
SRC_URI="http://www.nanoo.org/~daniel/moosic/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""
DEPEND="virtual/python"

src_compile() {
	./setup.py build || die
}

src_install() {
	./setup.py install --prefix ${D}/usr || die

	insinto /etc/bash_completion.d/
	newins examples/completion moosic
	dodoc ChangeLog
}
