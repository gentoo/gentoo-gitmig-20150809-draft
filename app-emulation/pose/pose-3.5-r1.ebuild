# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/pose/pose-3.5-r1.ebuild,v 1.8 2004/02/20 06:08:34 mr_bones_ Exp $

S=${WORKDIR}/Emulator_Src_3.5
FLTK_PV=1.0.11
FLTK_S=${WORKDIR}/fltk-${FLTK_PV}
HOMEPAGE="http://www.palmos.com/dev/tools/emulator/"
SRC_URI="http://www.palmos.com/dev/tools/emulator/sources/emulator_src_3.5.tar.gz
	ftp://www.easysw.com/pub/fltk/${FLTK_PV}/fltk-${FLTK_PV}-source.tar.bz2"

DESCRIPTION="Palm OS Emulator"

DEPEND="virtual/glibc"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_unpack() {
	unpack emulator_src_3.5.tar.gz
	unpack fltk-${FLTK_PV}-source.tar.bz2

	cd ${S}
	patch -p1 < ${FILESDIR}/detect-fluid.diff || die "Patching failed"
	patch -p1 < ${FILESDIR}/separate-builddir.diff || die "Patching failed"
	patch -p1 < ${FILESDIR}/choose-gl.diff || die "Patching failed"
	patch -p0 < ${FILESDIR}/init-clipwidget.diff || die "Patching failed"
	cd ${S}/BuildUnix
	aclocal
	automake --foreign
	autoconf

	cd ${S}
	mkdir install-fltk
	mkdir static-libs
	mkdir build-normal
	mkdir build-profile

	cd ${S}/static-libs
	ln -sf `g++ -print-file-name=libstdc++.a` libstdc++.a
}

src_compile() {
	cd ${FLTK_S}
	./configure --prefix=${S}/install-fltk --disable-gl --disable-shared || die
	make || die
	make install || die

	cd ${S}/build-normal
	LDFLAGS=-L${S}/static-libs ../BuildUnix/configure --prefix=/usr \
		--with-fltk=${S}/install-fltk \
		--disable-gl || die

	make || die

#	cd ${S}/build-profile
#	LDFLAGS=-L${S}/static-libs ../BuildUnix/configure --prefix=/usr \
#		--with-fltk=${S}/install-fltk \
#		--disable-gl --enable-palm-profile || die
#
#	make || die
}

src_install() {
	cd ${S}/build-normal
	dobin pose

#	cd ${S}/build-profile
#	newbin pose pose-profile

	cd ${S}/Docs
	dodoc *.txt *.rtf
	dohtml *.html
	insinto /usr/share/doc/${PF}
	doins *.pdf

	dodir /usr/share/pose/downloads
	dodir /usr/share/pose/roms

	cd ${S}/ROMTransfer/Source
	insinto /usr/share/pose/downloads
	doins *.prc
}

