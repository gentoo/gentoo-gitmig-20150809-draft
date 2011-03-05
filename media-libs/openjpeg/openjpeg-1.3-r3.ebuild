# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openjpeg/openjpeg-1.3-r3.ebuild,v 1.3 2011/03/05 00:56:01 ranger Exp $

inherit eutils toolchain-funcs multilib

MY_PV=${PV//./_}
DESCRIPTION="An open-source JPEG 2000 codec written in C"
HOMEPAGE="http://www.openjpeg.org/"
SRC_URI="http://www.openjpeg.org/openjpeg_v${MY_PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="tools"

DEPEND="tools? ( >=media-libs/tiff-3.8.2 )"
RDEPEND=${DEPEND}

S=${WORKDIR}/OpenJPEG_v${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch #258373
	cp "${FILESDIR}"/${PF}-codec-Makefile "${S}"/codec/Makefile
	epatch "${FILESDIR}"/${P}-freebsd.patch #253012
	epatch "${FILESDIR}"/${P}-darwin.patch # needs to go after freebsd patch
	sed -i 's:defined(HAVE_STDBOOL_H):1:' libopenjpeg/openjpeg.h || die #305333
}

src_compile() {
	tc-export CC AR
	# XXX: the -fPIC is wrong because it builds the libopenjpeg.a
	# as a PIC library too.  Should build up two sets of objects.
	emake CC="$CC" AR="$AR" LIBRARIES="-lm" COMPILERFLAGS="${CFLAGS} ${CPPFLAGS} -fPIC" || die "emake failed"
	if use tools ; then
		ln -s libopenjpeg.so.* libopenjpeg.so || die
		emake -C codec || die "emake failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" INSTALL_LIBDIR="/usr/$(get_libdir)" install || die "install failed"
	if use tools ; then
		emake -C codec DESTDIR="${D}" install || die "install failed"
	fi
	dodoc ChangeLog
}
