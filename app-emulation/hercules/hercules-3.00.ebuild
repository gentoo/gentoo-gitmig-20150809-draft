# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/hercules/hercules-3.00.ebuild,v 1.3 2004/02/17 03:23:55 mr_bones_ Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Hercules System/370, ESA/390 and zArchitecture Mainframe Emulator"
SRC_URI="http://www.conmicro.cx/hercules/${P}.tar.gz"
HOMEPAGE="http://www.conmicro.cx/hercules/"
LICENSE="QPL-1.0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	app-arch/bzip2"

src_compile() {
	local mycflags
	mycflags="${CFLAGS}"
	unset CFLAGS ; unset CXXFLAGS

	econf \
		--enable-optimization="${mycflags}" \
		--enable-cckd-bzip2 \
		--enable-het-bzip2 \
		--enable-setuid-hercifc \
		--enable-custom="Gentoo Linux ${PF}.ebuild" \
		--enable-multi-cpu=7 \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install
	dohtml -r html/
	insinto /usr/share/hercules
	doins hercules.cnf
	dodoc README.COMMADPT README.CVS README.ECPSVM README.HDL
	dodoc README.NETWORKING README.OSX README.TAPE
	dodoc RELEASE.NOTES CHANGES
}

pkg_postinst() {
	einfo
	einfo "Hercules System/370, ESA/390 and zArchitecture Mainframe"
	einfo "Emulator has been installed. Some useful utility files have"
	einfo "been placed in /usr/share/hercules. For detailed configuration"
	einfo "and operating instructions, see http://www.conmicro.cx/hercules"
	einfo
	einfo "In order to use Hercules you will need a guest operating"
	einfo "system. There are several flavours of 'Linux for S/390' and"
	einfo "'Linux for zSeries' available, or if you want that 'Big Iron'"
	einfo "feel, you can download several real mainframe operating systems"
	einfo "such as OS/360, DOS/VS, MVS, or VM370 from http://www.cbttape.org"
	einfo
	einfo "Hercules is also capable of runing OS/390, z/OS, and z/VM with an"
	einfo "appropriate liscense."
	einfo
}
