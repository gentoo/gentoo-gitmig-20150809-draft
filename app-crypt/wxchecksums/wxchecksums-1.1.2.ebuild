# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/wxchecksums/wxchecksums-1.1.2.ebuild,v 1.3 2004/07/26 23:59:08 mr_bones_ Exp $

MY_P="wxChecksums-${PV}"

DESCRIPTION="Calculate and verify CRC and MD5 checksums"
HOMEPAGE="http://wxchecksums.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxchecksums/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

RDEPEND=">=x11-libs/wxGTK-2.4.1-r1"
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
