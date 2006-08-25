# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jasper/jasper-1.701.0.ebuild,v 1.27 2006/08/25 06:17:48 phosphan Exp $

inherit libtool

DESCRIPTION="software-based implementation of the codec specified in the emerging JPEG-2000 Part-1 standard"
HOMEPAGE="http://www.ece.uvic.ca/~mdadams/jasper/"
SRC_URI="http://www.ece.uvic.ca/~mdadams/jasper/software/jasper-${PV}.zip"

LICENSE="JasPer"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="opengl jpeg"

RDEPEND="jpeg? ( media-libs/jpeg )
		opengl? ( virtual/opengl virtual/glut )"
DEPEND="${RDEPEND}
		app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd ${S}

	elibtoolize
}

src_compile() {
	econf \
		$(use_enable jpeg libjpeg) \
		$(use_enable opengl) \
		--enable-shared \
		|| die
	emake || die "If you got undefined references to OpenGL related libraries,please try 'eselect opengl set xorg-x11' before emerging. See bug #133609."
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc NEWS README doc/*
}
