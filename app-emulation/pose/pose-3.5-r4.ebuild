# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/pose/pose-3.5-r4.ebuild,v 1.1 2004/01/31 03:03:36 george Exp $

S=${WORKDIR}/Emulator_Src_3.5
HOMEPAGE="http://www.palmos.com/dev/tools/emulator/"
SRC_URI="http://www.palmos.com/dev/tools/emulator/sources/emulator_src_3.5.tar.gz"

DESCRIPTION="Palm OS Emulator"

DEPEND=">=x11-libs/fltk-1.1.4"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_unpack() {
	unpack emulator_src_3.5.tar.gz

	cd ${S}
	patch -p1 < ${FILESDIR}/detect-fluid.diff || die "Patching failed"
	patch -p1 < ${FILESDIR}/separate-builddir.diff || die "Patching failed"
	patch -p1 < ${FILESDIR}/choose-gl.diff || die "Patching failed"
	patch -p0 < ${FILESDIR}/init-clipwidget.diff || die "Patching failed"
	bzcat ${FILESDIR}/gcc-3.3_fix.diff.bz2 | patch -p1 || die "Patching failed"

	cd ${S}/BuildUnix
	aclocal
	automake --foreign
	autoconf
	#package build scripts dp not honor C[XX]FLAGS, will have to do corrections via sed here..
	sed -i -e "s:-DPLATFORM_UNIX:-DFLTK_1_0_COMPAT -DPLATFORM_UNIX:" \
		-e "s:-O2:-O2 -fno-strict-aliasing:" configure

	cd ${S}
	mkdir install-fltk
	ln -s /usr/include/fltk-1.1 install-fltk/include
	ln -s /usr/lib/fltk-1.1 install-fltk/lib
	mkdir static-libs
	mkdir build-normal
#	mkdir build-profile

	cd ${S}/static-libs
	ln -sf `g++ -print-file-name=libstdc++.a` libstdc++.a
}

src_compile() {
	cd ${S}/build-normal
#	cd ${S}/BuildUnix
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

