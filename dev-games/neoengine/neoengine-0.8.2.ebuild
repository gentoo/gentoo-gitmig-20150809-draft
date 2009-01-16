# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/neoengine/neoengine-0.8.2.ebuild,v 1.6 2009/01/16 20:38:49 tupone Exp $

inherit eutils autotools

DESCRIPTION="An open source, platform independent, 3D game engine written in C++"
HOMEPAGE="http://www.neoengine.org/"
SRC_URI="mirror://sourceforge/neoengine/${P}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"

RDEPEND="virtual/opengl
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/neoengine

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-gcc43.patch

	./setbuildtype.sh dynamic

	eautoreconf || die "eautoreconf failed"
	eautomake neodevopengl/Makefile || die "eautomake neodevopengl failed"
	eautomake neodevalsa/Makefile || die "eautomake neodevalsa failed"
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		|| die "econf failed"
	emake || die "emake failed"

	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog* NEWS README
	use doc && dohtml -r *-api
}
