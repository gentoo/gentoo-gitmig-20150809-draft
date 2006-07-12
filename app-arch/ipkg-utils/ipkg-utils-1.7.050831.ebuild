# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/ipkg-utils/ipkg-utils-1.7.050831.ebuild,v 1.1 2006/07/12 12:05:30 seemant Exp $

inherit distutils eutils toolchain-funcs versionator

MY_P=${PN}-$(get_version_component_range 3)

DESCRIPTION="Tools for working with the ipkg binary package format"
HOMEPAGE="http://www.openembedded.org/"
SRC_URI="http://handhelds.org/download/packages/ipkg-utils/${MY_P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~x86"
S=${WORKDIR}/${MY_P}

DEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}; cd ${S}

	epatch ${FILESDIR}/${PN}-1.7-build_fixes.patch
}

src_compile() {
	distutils_src_compile
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	distutils_src_install
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	einfo "Consider installing sys-apps/fakeroot for use with the ipkg-build command,"
	einfo "that makes it possible to build packages as a normal user."
}
