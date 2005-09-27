# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jasper/jasper-1.701.0.ebuild,v 1.19 2005/09/27 00:17:25 vapier Exp $

DESCRIPTION="software-based implementation of the codec specified in the emerging JPEG-2000 Part-1 standard"
HOMEPAGE="http://www.ece.uvic.ca/~mdadams/jasper/"
SRC_URI="http://www.ece.uvic.ca/~mdadams/jasper/software/jasper-${PV}.zip"

LICENSE="JasPer"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="opengl jpeg"

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl )"

src_compile() {
	econf \
		$(use_enable jpeg libjpeg) \
		$(use_enable opengl) \
		--enable-shared \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc NEWS README doc/*
}
