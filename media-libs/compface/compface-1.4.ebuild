# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/compface/compface-1.4.ebuild,v 1.20 2004/07/21 03:04:53 tgall Exp $

inherit eutils

DESCRIPTION="Utilities and library to convert to/from X-Face format"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/apps/graphics/convert/"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/graphics/convert/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-errno.diff
}

src_install() {
	dodir /usr/share/man/man{1,3} /usr/{bin,include,lib}
	make \
		prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		install || die

	dodoc README ChangeLog
}
