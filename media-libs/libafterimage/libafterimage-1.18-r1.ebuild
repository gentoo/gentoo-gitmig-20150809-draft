# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libafterimage/libafterimage-1.18-r1.ebuild,v 1.9 2010/11/11 10:08:26 ssuominen Exp $

EAPI=2
inherit eutils

MY_PN=libAfterImage

DESCRIPTION="Afterstep's standalone generic image manipulation library"
HOMEPAGE="http://www.afterstep.org/afterimage/index.php"
SRC_URI="ftp://ftp.afterstep.org/stable/${MY_PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="gif jpeg mmx nls png tiff examples"

RDEPEND="media-libs/freetype
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXrender
	png?  ( >=media-libs/libpng-1.4 )
	jpeg? ( virtual/jpeg )
	gif?  ( media-libs/giflib )
	tiff? ( media-libs/tiff )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	!x11-wm/afterstep"

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	# fix some ldconfig problem in makefile.in
	epatch "${FILESDIR}"/${PN}-makefile.in.patch
	# fix lib paths in afterimage-config
	epatch "${FILESDIR}"/${PN}-config.patch
	# Fix recursive make calls, bug #210965
	epatch "${FILESDIR}"/${P}-recmake_bsd.patch
	# fix x11-terms/rxvt-unicode segfault, bug #252651
	epatch "${FILESDIR}"/${P}-glx.patch
	# remove forced flags
	sed -i \
		-e 's/CFLAGS="-O3"//' \
		-e 's/ -rdynamic//' \
		configure || die "sed failed"
}

src_configure() {
	econf \
		$(use_enable nls i18n) \
		$(use_enable mmx mmx-optimization) \
		$(use_with png) \
		$(use_with jpeg) \
		$(use_with gif) \
		$(use_with tiff) \
		--enable-glx \
		--enable-sharedlibs \
		--with-x \
		--with-xpm \
		--without-builtin-gif \
		--without-builtin-ungif \
		--without-builtin-zlib \
		--without-afterbase
}

src_install() {
	emake \
		DESTDIR="${D}" \
		AFTER_DOC_DIR="${D}/usr/share/doc/${PF}" \
		install || die "emake install failed"
	dodoc ChangeLog README || die
	if use examples; then
		cd apps || die
		emake clean
		rm -f Makefile*
		insinto /usr/share/doc/${PF}/examples
		doins * || die "install examples failed"
	fi
}
