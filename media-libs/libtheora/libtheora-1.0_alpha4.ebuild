# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtheora/libtheora-1.0_alpha4.ebuild,v 1.5 2005/02/22 19:48:22 luckyduck Exp $
inherit flag-o-matic

DESCRIPTION="The Theora Video Compression Codec"
HOMEPAGE="http://www.theora.org/"
SRC_URI="http://downloads.xiph.org/releases/theora/${P/_}.tar.bz2"

LICENSE="xiph"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="encode pic doc"

RDEPEND=">=media-libs/libogg-1.1.0
	>=media-libs/libvorbis-1.0.1"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${P/_}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:SUBDIRS = .*:SUBDIRS = lib include doc:' Makefile.in
}

src_compile() {
	# bug #75403, -O3 needs to be filtered to -O2
	replace-flags -O3 -O2

	use doc ||
		export ac_cv_prog_HAVE_DOXYGEN="false"

	econf \
		$(use_enable encode) \
		$(use_with pic) \
		--enable-shared --disable-dependency-tracking || die
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		docdir=usr/share/doc/${PF} \
		install || die

	dodoc README
}
