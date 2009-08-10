# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libowfat/libowfat-0.28-r1.ebuild,v 1.1 2009/08/10 14:43:14 ssuominen Exp $

EAPI=2

DESCRIPTION="reimplement libdjb - excellent libraries from Dan Bernstein."
SRC_URI="http://dl.fefe.de/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/libowfat/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/dietlibc-0.33_pre20090721"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	sed -e "s:^CFLAGS.*:CFLAGS=-I. ${CFLAGS}:" \
		-e "s:^DIET.*:DIET=/usr/bin/diet -Os:" \
		-e "s:^prefix.*:prefix=/usr:" \
		-e "s:^INCLUDEDIR.*:INCLUDEDIR=\${prefix}/include/libowfat:" \
		-i GNUmakefile || die "sed failed"
}

src_install () {
	emake \
		LIBDIR="${D}/usr/lib" \
		MAN3DIR="${D}/usr/share/man/man3" \
		INCLUDEDIR="${D}/usr/include/libowfat" \
		install || die "emake install failed"

	cd "${D}"/usr/share/man
	mv man3/buffer.3 man3/owfat-buffer.3
}
