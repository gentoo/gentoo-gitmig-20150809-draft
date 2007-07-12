# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libafterimage/libafterimage-1.07.ebuild,v 1.2 2007/07/12 03:10:24 mr_bones_ Exp $

inherit eutils autotools

MY_PN="libAfterImage"

DESCRIPTION="Afterstep's standalone generic image manipulation library"
HOMEPAGE="http://www.afterstep.org/afterimage/index.php"
SRC_URI="ftp://ftp.afterstep.org/stable/${MY_PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gif jpeg mmx nls png tiff examples"

RDEPEND="media-libs/freetype
	|| ( (	x11-libs/libICE
			x11-libs/libSM
			x11-libs/libXext
			x11-libs/libXrender
			x11-libs/libX11
		  )
		virtual/x11
		)
	png?  ( >=media-libs/libpng-1.2.5 )
	jpeg? ( >=media-libs/jpeg-6b )
	gif?  ( >=media-libs/giflib-4.1 )
	tiff? ( >=media-libs/tiff-3.5.7 )"

DEPEND="${RDEPEND}
	!x11-wm/afterstep"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A}
	# patch to build the test apps examples if use=test
	epatch "${FILESDIR}"/${PN}-examples.patch
	cd "${S}"
	# patch for afterimage-config
	epatch "${FILESDIR}"/${PN}-config.patch
	# remove forced flags
	sed -i \
		-e 's/CFLAGS="-O3"//' \
		-e 's/ -rdynamic//' \
		configure || die "sed failed"

	eautomake
}

src_compile() {
	econf \
		$(use_enable nls i18n) \
		$(use_enable mmx mmx-optimization) \
		$(use_with png) \
		$(use_with jpeg) \
		$(use_with gif) \
		$(use_with tiff) \
		--enable-glx \
		--enable-sharedlibs \
		--disable-staticlibs \
		--with-x \
		--with-xpm \
		--without-builtin-ungif \
		--without-afterbase \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	dodir /usr/include
	dodir /usr/bin
	dodir /usr/$(get_libdir)
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins apps/*
	fi
}
