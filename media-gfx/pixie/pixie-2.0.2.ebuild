# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixie/pixie-2.0.2.ebuild,v 1.1 2007/03/09 13:01:33 armin76 Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools flag-o-matic

IUSE="X openexr"

MY_PN="Pixie"
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="RenderMan like photorealistic renderer."
HOMEPAGE="http://pixie.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-src-${PV}.tgz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"

RDEPEND="media-libs/jpeg
	 sys-libs/zlib
	 media-libs/tiff
	 openexr? ( media-libs/openexr )
	 X? ( x11-libs/libXext )"

src_compile() {
	strip-flags
	replace-flags -O? -O2

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
