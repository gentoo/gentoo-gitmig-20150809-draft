# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/wxchecksums/wxchecksums-1.2.0.ebuild,v 1.4 2006/10/04 12:18:01 blubb Exp $

MY_P="wxChecksums-${PV}"

DESCRIPTION="Calculate and verify CRC and MD5 checksums"
HOMEPAGE="http://wxchecksums.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxchecksums/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="<x11-libs/wxGTK-2.5"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"
S="${WORKDIR}/${MY_P}/src"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Modify CXXFLAGS
	sed -i \
		-e "s:-O2:${CXXFLAGS}:" \
		makefile || die "sed makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make \
		PREFIX=${D}/usr \
		install || die "make install failed"

	cd ..
	dodoc AUTHORS.txt NEWS.txt README.txt TODO.txt

	if use doc ; then
		dohtml -r manual/*
	fi
}

pkg_postinst() {
	if use doc ; then
		einfo "The manual has been installed in"
		einfo "/usr/share/doc/${PF}/html"
	fi
}
