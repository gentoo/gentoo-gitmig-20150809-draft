# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/TheUnarchiver/TheUnarchiver-2.7.1.ebuild,v 1.1 2011/10/08 18:12:47 hanno Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Unpacker for various archiving formats, e.g. rar v3."
HOMEPAGE="http://wakaba.c3.cx/s/apps/unarchiver.html"
SRC_URI="http://theunarchiver.googlecode.com/files/${PN}${PV}_src.zip"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="gnustep-base/gnustep-base
	gnustep-base/gnustep-make[native-exceptions]"
DEPEND="${RDEPEND}
	sys-devel/gcc[objc]"

S="${WORKDIR}/The Unarchiver/XADMaster"

#src_prepare() {
#	sed -i -e 's:-D_NATIVE_OBJC_EXCEPTIONS::g' Makefile.linux \
#		../UniversalDetector/Makefile.linux || die "sed failed"
#}

src_compile() {
	emake -f Makefile.linux \
		CC="$(tc-getCC)" \
		OBJCC="$(tc-getCC)" \
		C_OPTS="-std=gnu99 ${CFLAGS}" \
		OBJC_OPTS="-std=gnu99 ${CFLAGS}" \
		LD="$(tc-getCC)" \
		LDFLAGS="-Wl,--whole-archive -fexceptions -fgnu-runtime \
		${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin unar lsar || die "dobin failed"
}
