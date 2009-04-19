# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/ghdl/ghdl-0.26.ebuild,v 1.5 2009/04/19 02:50:42 calchan Exp $

inherit multilib

GCC_VERSION="4.1.2"

DESCRIPTION="Complete VHDL simulator using the GCC technology"
HOMEPAGE="http://ghdl.free.fr"
SRC_URI="http://ghdl.free.fr/${P}.tar.bz2
	mirror://gnu/gcc/releases/gcc-${GCC_VERSION}/gcc-core-${GCC_VERSION}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=sys-apps/portage-2.1.2.10
	virtual/gnat"
RDEPEND=""
S="${WORKDIR}/gcc-${GCC_VERSION}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv "${WORKDIR}/${P}"/vhdl gcc
	sed -i \
		-e 's/ADAC = \$(CC)/ADAC = gnatgcc/' \
		-e '/^CFLAGS = -g/d' \
		gcc/vhdl/Makefile.in || die "sed failed"
	sed -i -e 's/"-O -g"/"$(CFLAGS)"/' gcc/vhdl/Make-lang.in || die "sed failed"

	# Fix issue similar to bug #195074, ported from vapier's fix for binutils
	sed -i -e "s:egrep.*texinfo.*dev/null:egrep 'texinfo[^0-9]*(4\.([4-9]|[1-9][0-9])|[5-9]|[1-9][0-9])' >/dev/null:" \
		configure* || die "sed failed"

	# Fix atan2 bug in math_complex-body.vhdl
	sed -i -e 's/atan2(z.re,z.im)/atan2(z.im,z.re)/' \
		gcc/vhdl/libraries/ieee/math_complex-body.vhdl || die "sed failed"

	# For multilib profile arch, see bug #203721
	if (has_multilib_profile || use multilib ) ; then
		for T_LINUX64 in `find "${S}/gcc/config" -name t-linux64` ;
		do
			einfo "sed for ${T_LINUX64} for multilib. :)"
			sed -i \
				-e "s:\(MULTILIB_OSDIRNAMES = \).*:\1../lib64 ../lib32:" \
				"${T_LINUX64}" \
			|| die "sed for ${T_LINUX64} failed. :("
		done
	fi
}

src_compile() {
	econf --enable-languages=vhdl
	emake -j1 || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"

	cd "${D}"/usr/bin ; rm `ls --ignore=ghdl`
	rm -rf "${D}"/usr/include
	rm "${D}"/usr/$(get_libdir)/lib*
	cd "${D}"/usr/$(get_libdir)/gcc/${CHOST}/${GCC_VERSION} ; rm -rf `ls --ignore=vhdl*`
	cd "${D}"/usr/libexec/gcc/${CHOST}/${GCC_VERSION} ; rm -rf `ls --ignore=ghdl*`
	cd "${D}"/usr/share/info ; rm `ls --ignore=ghdl*`
	cd "${D}"/usr/share/man/man1 ; rm `ls --ignore=ghdl*`
	rm -Rf "${D}"/usr/share/locale
	rm -Rf "${D}"/usr/share/man/man7
}
