# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/hercules/hercules-2.17.1.ebuild,v 1.2 2003/06/29 20:06:54 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Hercules System/370, ESA/390 and zArchitecture Mainframe Emulator"
SRC_URI="http://www.conmicro.cx/hercules/${P}.tar.gz"
HOMEPAGE="http://www.conmicro.cx/hercules/"
LICENSE="QPL-1.0"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	sys-apps/bzip2"

src_compile() {
	econf --enable-optimization="${CFLAGS}" \
		--enable-cckd-bzip2 \
		--enable-het-bzip2 \
		--enable-setuid-hercifc \
		--enable-custom="Gentoo Linux ${PF}.ebuild" \
		|| die

	make || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc INSTALL

	dohtml html/*.html html/hercules.css

	insinto /usr/share/hercules
	doins hercules.cnf
}

pkg_postinst() {

	einfo
	einfo "Hercules System/370, ESA/390 and zArchitecture Mainframe"
	einfo "Emulator has been installed. Some useful utility files have"
	einfo "been placed in /usr/share/hercules. For detailed configuration"
	einfo "and operating instructions, see http://www.conmicro.cx/hercules"
	einfo
	einfo "In order to use Hercules you will need a guest operating"
	einfo "system. There are several flavours of 'Linux for S/390'"
	einfo "available, or if you want that 'Big Iron' feel, you can"
	einfo "download several real mainframe operating systems such as"
	einfo "OS/360, MVS 3.8J or VM370r6 from http://www.cbttape.org"
	einfo

}
