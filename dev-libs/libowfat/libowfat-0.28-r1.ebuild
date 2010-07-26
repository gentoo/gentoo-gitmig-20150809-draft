# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libowfat/libowfat-0.28-r1.ebuild,v 1.3 2010/07/26 16:28:25 gmsoft Exp $

EAPI=2
inherit flag-o-matic

DESCRIPTION="reimplement libdjb - excellent libraries from Dan Bernstein."
SRC_URI="http://dl.fefe.de/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/libowfat/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/dietlibc-0.33_pre20090721"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

pkg_setup() {
	# Required for mult/umult64.c to be usable
	append-flags -fomit-frame-pointer
}

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
