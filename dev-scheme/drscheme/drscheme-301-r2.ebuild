# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/drscheme/drscheme-301-r2.ebuild,v 1.1 2006/04/12 02:05:31 chutzpah Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="DrScheme programming environment.  Includes mzscheme."
HOMEPAGE="http://www.plt-scheme.org/software/drscheme/"
SRC_URI="http://download.plt-scheme.org/bundles/${PV}/plt/plt-${PV}-src-unix.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cairo jpeg opengl perl png"

DEPEND="|| ( ( x11-libs/libICE
			x11-libs/libSM
			x11-libs/libXaw
			x11-libs/libXft
		)
		virtual/x11
	)
	media-libs/freetype
	media-libs/fontconfig
	cairo? ( x11-libs/cairo )
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )"

S=${WORKDIR}/plt/src
SED_FILES="bin/framework-test bin/framework-test-engine collects/info-domain/compiled/cache.ss"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/plt

	epatch "${FILESDIR}/${P}-fPIC.patch"
	epatch "${FILESDIR}/${P}-no-setfont.patch"
}

src_compile() {

	econf --enable-mred \
		$(use_enable opengl gl) \
		$(use_enable png libpng) \
		$(use_enable jpeg libjpeg) \
		$(use_enable perl) \
		$(use_enable cairo) \
		--prefix=/usr/$(get_libdir)/${PN}/ || die "econf failed"

	make || die
}

src_install() {
	cd ${S}

	sed -ie 's/cp -p/cp/' Makefile

	dodir /usr/$(get_libdir)
	make prefix=${D}/usr/$(get_libdir)/${PN} install || die "make install failed"

	dodoc README
	cd ${D}/usr/$(get_libdir)/${PN}/man/man1
	doman *
	rm -rf ${D}/usr/$(get_libdir)/${PN}/man

	# create symlinks for all the executables
	dodir /usr/bin
	MY_D="${D%/}"
	MY_D="${MY_D//\//\/}"

	cd ${D}/usr/$(get_libdir)/${PN}/bin
	for EXE in *; do

		# fix paths in generated shell scripts
		file -b "${EXE}" | grep -q "Bourne shell" && \
			sed -i "s/${MY_D}//g" "${EXE}"

		dosym "/usr/$(get_libdir)/${PN}/bin/${EXE}" "/usr/bin/${EXE}"
	done

	for FILE in ${SED_FILES}; do
		sed -i "s/${MY_D}//g" "${D}/usr/$(get_libdir)/${PN}/${FILE}"
	done

}
