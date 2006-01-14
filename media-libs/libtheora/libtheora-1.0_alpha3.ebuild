# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtheora/libtheora-1.0_alpha3.ebuild,v 1.21 2006/01/14 00:03:30 vapier Exp $

inherit flag-o-matic

DESCRIPTION="The Theora Video Compression Codec"
HOMEPAGE="http://www.theora.org/"
SRC_URI="http://www.theora.org/files/${P/_}.tar.bz2"

LICENSE="xiph"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 sh sparc x86"
IUSE=""

DEPEND=">=media-libs/libogg-1.1.0
	>=media-libs/libvorbis-1.0.1"

S=${WORKDIR}/${P/_}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:SUBDIRS = .*:SUBDIRS = lib include doc:' Makefile.in
}

src_compile() {
	# bug #75403, filter -O3 to -O2
	replace-flags -O3 -O2
	econf --enable-shared || die
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		install || die

	dodoc README
}
