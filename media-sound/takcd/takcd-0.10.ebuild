# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/takcd/takcd-0.10.ebuild,v 1.3 2004/03/01 05:37:16 eradicator Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Command line CD player"
HOMEPAGE="http://bard.sytes.net/takcd/"
SRC_URI="http://bard.sytes.net/takcd/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 ~amd64"

DEPEND="virtual/glibc"

src_compile() {
	./autogen.sh
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog NEWS README* TODO
}
