# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtheora/libtheora-1.0_alpha5.ebuild,v 1.1 2005/08/21 16:31:54 lu_zero Exp $
inherit flag-o-matic

DESCRIPTION="The Theora Video Compression Codec"
HOMEPAGE="http://www.theora.org/"
SRC_URI="http://downloads.xiph.org/releases/theora/${P/_}.tar.bz2"

LICENSE="xiph"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="encode doc"

RDEPEND=">=media-libs/libogg-1.1.0
	>=media-libs/libvorbis-1.0.1"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${P/_}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:SUBDIRS = .*:SUBDIRS = lib include doc:' Makefile.in
	# fix stupid --enable flags
	cd ${S}
}

src_compile() {

	# bug #75403, -O3 needs to be filtered to -O2
	replace-flags -O3 -O2

	use doc ||
		export ac_cv_prog_HAVE_DOXYGEN="false"

	econf \
		$(use_enable encode) \
		--enable-shared --disable-dependency-tracking || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make \
		DESTDIR=${D} \
		docdir=usr/share/doc/${PF} \
		install || die "make install failed"

	dodoc README
}
