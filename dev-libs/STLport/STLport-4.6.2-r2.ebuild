# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-4.6.2-r2.ebuild,v 1.7 2006/05/01 12:25:48 corsair Exp $

inherit eutils multilib

DESCRIPTION="C++ STL library"
HOMEPAGE="http://www.stlport.org/"
SRC_URI="http://www.stlport.org/archive/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-optimize.patch
	epatch "${FILESDIR}"/${PV}-gcc-includes.patch
	sed -i 's:-D_STLP_REAL_LOCALE_IMPLEMENTED::' src/gcc-linux.mak
	if ( use ppc || use ppc64 ) ; then
		epatch "${FILESDIR}"/STLport-vector.patch
	fi
}

src_compile() {
	emake -C src -f gcc-linux.mak || die "Compile failed"
}

src_install() {
	dodir /usr/include
	cp -R "${S}"/stlport "${D}"/usr/include || die "doins include"
	rm -rf "${D}"/usr/include/stlport/BC50
	chmod -R a+r "${D}"/usr/include/stlport

	dodir /usr/$(get_libdir)
	cp -R "${S}"/lib/* "${D}"/usr/$(get_libdir)/ || die "doins libs"
	dosym libstlport_gcc_stldebug.so /usr/$(get_libdir)/libstlport_gcc_debug.so
	rm -rf "${D}"/usr/$(get_libdir)/obj

	cd "${S}"/etc/
	dodoc ChangeLog* README TODO *.txt

	cd "${S}"
	dohtml -r doc
}

pkg_postinst() {
	einfo "Running \`chmod -R a+r ${ROOT}/usr/include/stlport\` to fix #56245"
	chmod -R a+r ${ROOT}/usr/include/stlport
}
