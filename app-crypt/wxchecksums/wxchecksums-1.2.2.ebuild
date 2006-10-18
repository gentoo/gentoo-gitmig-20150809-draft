# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/wxchecksums/wxchecksums-1.2.2.ebuild,v 1.4 2006/10/18 04:50:38 tsunam Exp $

inherit eutils wxwidgets

MY_P="wxChecksums-${PV}"

DESCRIPTION="Calculate and verify CRC and MD5 checksums"
HOMEPAGE="http://wxchecksums.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxchecksums/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="doc"

RDEPEND=">=x11-libs/wxGTK-2.6.1"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}/src"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Modify CXXFLAGS
	sed -i \
		-e "s:-O2:${CXXFLAGS}:" \
		-e "s:wx-config:wx-config-2.6:" \
		makefile || die "sed makefile failed"

	epatch "${FILESDIR}/${PN}-gcc4.patch"
	epatch "${FILESDIR}/${PN}-64bit.patch"
	epatch "${FILESDIR}/${P}-wxdebug_build.patch"
}

pkg_setup() {
	export WX_GTK_VER="2.6"
	need-wxwidgets unicode
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
		elog "The manual has been installed in /usr/share/doc/${PF}/html"
	fi
}
