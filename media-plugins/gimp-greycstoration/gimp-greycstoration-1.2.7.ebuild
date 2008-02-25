# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gimp-greycstoration/gimp-greycstoration-1.2.7.ebuild,v 1.1 2008/02/25 10:08:46 calchan Exp $

inherit toolchain-funcs

DESCRIPTION="GIMP plug-in for denoising through image regularization"
HOMEPAGE="http://www.greyc.ensicaen.fr/~dtschump/greycstoration/"
SRC_URI="mirror://sourceforge/cimg/CImg-${PV}.tar.gz"
LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=media-gfx/gimp-2.2"
S="${WORKDIR}/CImg-${PV}"

src_unpack() {
	unpack ${A}
	mv "${S}"/examples/greycstoration4gimp.cpp "${S}"
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
