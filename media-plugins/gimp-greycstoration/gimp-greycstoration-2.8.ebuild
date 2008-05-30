# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gimp-greycstoration/gimp-greycstoration-2.8.ebuild,v 1.2 2008/05/30 11:08:12 calchan Exp $

inherit toolchain-funcs

DESCRIPTION="GIMP plug-in for denoising through image regularization"
HOMEPAGE="http://www.greyc.ensicaen.fr/~dtschump/greycstoration/"
SRC_URI="mirror://sourceforge/cimg/GREYCstoration-${PV}.zip"
LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="smp"
RDEPEND=">=media-gfx/gimp-2.2"
DEPEND="${RDEPEND}
	app-arch/unzip"
S="${WORKDIR}/GREYCstoration-${PV}/src"

src_unpack() {
	unpack ${A}
	sed -i -e "s:plugins/../CImg.h:CImg.h:" "${S}"/greycstoration4gimp.cpp || die "sed failed"
	if use smp ; then
		sed -i -e "s:^#define NTHREADS 1:#define NTHREADS 4:" "${S}"/greycstoration4gimp.cpp || die "sed failed"
	fi
}

src_compile() {
	$(tc-getCXX) -o greycstoration greycstoration4gimp.cpp \
		$(gimptool-2.0 --cflags) $(gimptool-2.0 --libs) \
		-lpthread ${CXXFLAGS} ${LDFLAGS} \
		|| die "Compilation failed"
}

src_install() {
	exeinto $(gimptool-2.0 --gimpplugindir)/plug-ins
	doexe greycstoration || die "Installation failed"
}

pkg_postinst() {
	elog "The GREYCstoration plugin is accessible from the menu :"
	elog "Filters -> Enhance -> GREYCstoration"
}
