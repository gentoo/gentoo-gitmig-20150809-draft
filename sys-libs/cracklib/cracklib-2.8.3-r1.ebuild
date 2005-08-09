# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.8.3-r1.ebuild,v 1.13 2005/08/09 00:45:01 ka0ttic Exp $

inherit eutils toolchain-funcs multilib

MY_P=${P/_}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://sourceforge.net/projects/cracklib"
SRC_URI="mirror://sourceforge/cracklib/${MY_P}.tar.gz"

LICENSE="CRACKLIB"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/cracklib-2.8.3-dictname.patch
	epatch "${FILESDIR}"/cracklib-2.8.3-packer-defines.patch
	epunt_cxx
}

src_compile() {
	econf --disable-dependency-tracking || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -r "${D}"/usr/share/cracklib

	insinto /usr/include
	doins lib/packer.h || die "doins packer.h"

	# move shared libs to /
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)/ || die "could not move shared"
	gen_usr_ldscript libcrack.so

	echo -n "Generating cracklib dicts ... "
	insinto /usr/share/dict
	doins dicts/cracklib-small || die "word dict"
	tc-is-cross-compiler \
		|| export PATH=${D}/usr/sbin:${PATH} LD_LIBRARY_PATH=${D}/$(get_libdir)
	cracklib-format dicts/cracklib-small \
		| cracklib-packer "${D}"/usr/$(get_libdir)/cracklib_dict \
		|| die "couldnt create dict"

	dodoc AUTHORS ChangeLog NEWS README*
}
