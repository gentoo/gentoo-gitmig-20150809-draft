# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aacplusenc/aacplusenc-0.17.1.ebuild,v 1.3 2009/07/22 19:54:56 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="High-Efficiency AAC (AAC+) Encoder"
HOMEPAGE="http://teknoraver.net/software/mp4tools/"
SRC_URI="http://teknoraver.net/software/mp4tools/${P}.tar.bz2"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sci-libs/fftw:3.0"
DEPEND="${RDEPEND}
	sys-apps/sed"

# 3GPP patenting issues
RESTRICT="mirror"

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	sed \
		-e 's:LDFLAGS:LIBRARIES:g' \
		-e 's:$(CC) $(CFLAGS):$(CC) $(LDFLAGS) $(CFLAGS):' \
		-e 's:ar r:$(AR) r:g' \
		-e 's:strip:true:' \
		-e 's:-O3 -ftree-vectorize::' \
		-i configure Makefile lib*/Makefile || die "sed failed"
}

src_configure() {
	tc-export AR CC
	./configure || die "./configure failed"
}

src_compile() {
	emake EXTRACFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake INSTDIR="${D}/usr" install || die "emake install failed"
	doman ${PN}.1
	dodoc CHANGELOG
}
