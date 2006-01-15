# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/pose/pose-3.5-r4.ebuild,v 1.7 2006/01/15 21:42:41 vanquirius Exp $

inherit eutils

S="${WORKDIR}/Emulator_Src_3.5"
HOMEPAGE="http://www.palmos.com/dev/tools/emulator/"
SRC_URI="http://www.palmos.com/dev/tools/emulator/sources/emulator_src_3.5.tar.gz
	mirror://gentoo/${P}-genpatches.tar.bz2"

DESCRIPTION="Palm OS Emulator"

DEPEND=">=x11-libs/fltk-1.1.4"

KEYWORDS="x86 -ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}; cd "${S}"

	epatch "${WORKDIR}"/detect-fluid.diff
	epatch "${WORKDIR}"/separate-builddir.diff
	epatch "${WORKDIR}"/choose-gl.diff
	epatch "${WORKDIR}"/init-clipwidget.diff
	epatch "${WORKDIR}"/gcc-3.3_fix.diff.bz2

	cd "${S}"/BuildUnix
	aclocal
	automake --foreign
	autoconf
	#package build scripts dp not honor C[XX]FLAGS, will have to do corrections via sed here..
	sed -i -e "s:-DPLATFORM_UNIX:-DFLTK_1_0_COMPAT -DPLATFORM_UNIX:" \
		-e "s:-O2:-O2 -fno-strict-aliasing:" configure

	cd "${S}"
	mkdir install-fltk
	ln -s /usr/include/fltk-1.1 install-fltk/include
	ln -s /usr/lib/fltk-1.1 install-fltk/lib
	mkdir static-libs
	mkdir build-normal
#	mkdir build-profile

	cd "${S}"/static-libs
	ln -sf `g++ -print-file-name=libstdc++.a` libstdc++.a
}

src_compile() {
	cd "${S}"/build-normal
#	cd ${S}/BuildUnix
	LDFLAGS=-L"${S}"/static-libs ../BuildUnix/configure --prefix=/usr \
		--with-fltk="${S}"/install-fltk \
		--disable-gl || die

	emake || die

#	cd ${S}/build-profile
#	LDFLAGS=-L${S}/static-libs ../BuildUnix/configure --prefix=/usr \
#		--with-fltk=${S}/install-fltk \
#		--disable-gl --enable-palm-profile || die
#
#	make || die
}

src_install() {
	cd "${S}"/build-normal
	dobin pose

#	cd ${S}/build-profile
#	newbin pose pose-profile

	cd "${S}"/Docs
	dodoc *.txt *.rtf
	dohtml *.html
	insinto /usr/share/doc/${PF}
	doins *.pdf

	dodir /usr/share/pose/downloads
	dodir /usr/share/pose/roms

	cd "${S}"/ROMTransfer/Source
	insinto /usr/share/pose/downloads
	doins *.prc
}

