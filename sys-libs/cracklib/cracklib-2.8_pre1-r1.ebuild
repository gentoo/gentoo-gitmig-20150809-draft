# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.8_pre1-r1.ebuild,v 1.1 2005/03/01 22:20:11 vapier Exp $

inherit eutils toolchain-funcs

MY_P=${P/_}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://sourceforge.net/projects/cracklib"
SRC_URI="mirror://sourceforge/cracklib/${MY_P}.tar.gz"

LICENSE="CRACKLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="minimal"

RDEPEND="sys-apps/miscfiles"
DEPEND="${RDEPEND}
	uclibc? ( app-arch/gzip )
	sys-devel/gcc-config"
PDEPEND="!minimal? ( sys-apps/cracklib-words )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-dictname.patch
}

src_compile() {
	econf --disable-dependency-tracking || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -r "${D}"/usr/share/cracklib

	# move shared libs to /
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)/ || die "could not move shared"
	gen_usr_ldscript libcrack.so

	insinto /usr/share/dict
	doins dicts/cracklib-small || die "word dict"
	export PATH=${PATH}:${D}/usr/sbin
	cracklib-format dicts/cracklib-small \
		| cracklib-packer "${D}"/usr/$(get_libdir)/cracklib_dict \
		|| die "couldnt create dict"

	dodoc AUTHORS ChangeLog NEWS README*
}
