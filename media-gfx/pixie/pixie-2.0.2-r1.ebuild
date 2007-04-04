# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixie/pixie-2.0.2-r1.ebuild,v 1.7 2007/04/04 08:11:39 eradicator Exp $

inherit multilib

IUSE="fltk openexr X"

MY_PN="Pixie"
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="RenderMan like photorealistic renderer."
HOMEPAGE="http://pixie.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-src-${PV}.tgz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"

RDEPEND="media-libs/jpeg
	 sys-libs/zlib
	 media-libs/tiff
	 openexr? ( media-libs/openexr )
	 fltk? ( x11-libs/fltk )
	 X? ( x11-libs/libXext )"

src_compile() {
	strip-flags
	replace-flags -O? -O2

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
	doins ${S}/textures/checkers.tif

	edos2unix ${D}/usr/share/Pixie/shaders/*
	mv ${D}/usr/share/doc/Pixie ${D}/usr/share/doc/${PF}
}
