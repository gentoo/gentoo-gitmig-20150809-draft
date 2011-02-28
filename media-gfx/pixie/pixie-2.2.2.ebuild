# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixie/pixie-2.2.2.ebuild,v 1.9 2011/02/28 17:51:05 ssuominen Exp $

EAPI=1

inherit eutils multilib autotools

IUSE="fltk openexr X"

MY_PN="Pixie"
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="RenderMan like photorealistic renderer."
HOMEPAGE="http://pixie.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-src-${PV}.tgz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND="virtual/jpeg
	 sys-libs/zlib
	 media-libs/tiff
	 openexr? ( media-libs/openexr )
	 fltk? ( x11-libs/fltk:1.1 )
	 X? ( x11-libs/libXext )"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# Force make to rebuild the shaders since the packaged ones
	# are not always compiled with the latest version of sdr
	epatch "${FILESDIR}/${PN}-2.2.1-genshaders.patch"
	rm "${S}/shaders/*.sdr"

	eautoreconf
}

src_compile() {
	ewarn "Compilation of pixie is memory intensive.  If you experience problems, try"
	ewarn "removing -pipe from your CFLAGS.  Additionally, disabling optimizations (-O0)"
	ewarn "will cause much less memory consumption.  See bug #171367 for more info."

	econf || die "econf failed"
	emake -j1 || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	keepdir /usr/$(get_libdir)/Pixie/procedurals
	keepdir /usr/share/Pixie/models

	insinto /usr/share/Pixie/textures
	doins "${S}/textures/checkers.tif"

	dodir /usr/share/doc
	mv "${D}/usr/doc" "${D}/usr/share/doc/${PF}"
}
