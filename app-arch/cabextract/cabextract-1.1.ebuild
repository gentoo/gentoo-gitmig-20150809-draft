# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cabextract/cabextract-1.1.ebuild,v 1.5 2004/10/31 10:30:46 kloeri Exp $

DESCRIPTION="Extracts files from Microsoft .cab files"
HOMEPAGE="http://www.kyz.uklinux.net/cabextract.php"
SRC_URI="http://www.kyz.uklinux.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO doc/magic
}
