# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixie/pixie-1.7.6.ebuild,v 1.1 2007/02/12 04:44:59 eradicator Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

IUSE="X openexr"

MY_PN="Pixie"
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="RenderMan like photorealistic renderer."
HOMEPAGE="http://pixie.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-src-${PV}.tgz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="-amd64 ~ppc ~sparc ~x86"

RDEPEND="media-libs/jpeg
	 sys-libs/zlib
	 media-libs/tiff
	 openexr? ( media-libs/openexr )
	 X? ( || ( x11-libs/libXext virtual/x11 ) )"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# Don't install a lib with a name like 'libcommon'.	 Renaming it to libpixiecommon
	epatch ${FILESDIR}/${PN}-1.7.6-libcommon.patch

	eautoreconf
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
