# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sge/sge-030809.ebuild,v 1.1 2006/04/08 03:00:44 vapier Exp $

inherit eutils

MY_P="sge${PV}"
DESCRIPTION="Graphics extensions library for SDL"
HOMEPAGE="http://www.etek.chalmers.se/~e8cal1/sge/"
SRC_URI="http://www.etek.chalmers.se/~e8cal1/sge/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples image truetype"

RDEPEND=">=media-libs/libsdl-1.2
	image? ( >=media-libs/sdl-image-1.2 )
	truetype? ( >=media-libs/freetype-2 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-freetype.patch
	epatch "${FILESDIR}"/${P}-cmap.patch
}

src_compile() {
	# make sure the header gets regenerated everytime
	rm -f sge_config.h

	yesno() { use $1 && echo y || echo n ; }
	emake \
		USE_IMG=$(yesno image) \
		USE_FT=$(yesno truetype) \
		|| die "emake failed"

	if use examples ; then
		cd examples
		emake -j1 \
			USE_IMG=$(yesno image) \
			USE_FT=$(yesno truetype) \
			|| die "emake (examples) failed"
	fi
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc README Todo WhatsNew

	use doc && dohtml docs/*

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "examples failed"
	fi
}
