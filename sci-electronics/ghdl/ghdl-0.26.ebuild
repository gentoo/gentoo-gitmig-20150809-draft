# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/ghdl/ghdl-0.26.ebuild,v 1.1 2007/06/29 21:11:15 calchan Exp $

inherit multilib

GCC_VERSION="4.1.2"

DESCRIPTION="Complete VHDL simulator using the GCC technology"
HOMEPAGE="http://ghdl.free.fr"
SRC_URI="http://ghdl.free.fr/${P}.tar.bz2
	mirror://gnu/gcc/releases/gcc-${GCC_VERSION}/gcc-core-${GCC_VERSION}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=sys-apps/portage-2.1.2.10
	virtual/gnat"
RDEPEND=""
S="${WORKDIR}/gcc-${GCC_VERSION}"
MAKEOPTS="-j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ${WORKDIR}/${P}/vhdl gcc
	sed -i \
		-e 's/ADAC = \$(CC)/ADAC = gnatgcc/' \
		-e '/^CFLAGS = -g/d' \
		gcc/vhdl/Makefile.in || die "sed failed"
	sed -i -e 's/"-O -g"/"$(CFLAGS)"/' gcc/vhdl/Make-lang.in || die "sed failed"

	# Fix atan2 bug in math_complex-body.vhdl
	sed -i -e 's/atan2(z.re,z.im)/atan2(z.im,z.re)/' \
		gcc/vhdl/libraries/ieee/math_complex-body.vhdl || die "sed failed"
}

src_compile() {
	econf --enable-languages=vhdl || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"

	cd ${D}/usr/bin ; rm `ls --ignore=ghdl`
	rm -rf ${D}/usr/include
	rm ${D}/usr/$(get_libdir)/lib*
	cd ${D}/usr/$(get_libdir)/gcc/${CHOST}/${GCC_VERSION} ; rm -rf `ls --ignore=vhdl*`
	cd ${D}/usr/libexec/gcc/${CHOST}/${GCC_VERSION} ; rm -rf `ls --ignore=ghdl*`
	cd ${D}/usr/share/info ; rm `ls --ignore=ghdl*`
	cd ${D}/usr/share/man/man1 ; rm `ls --ignore=ghdl*`
	rm -Rf ${D}/usr/share/locale
	rm -Rf ${D}/usr/share/man/man7
}
