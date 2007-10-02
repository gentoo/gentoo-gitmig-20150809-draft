# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.8.12.ebuild,v 1.1 2007/10/02 06:46:00 vapier Exp $

inherit toolchain-funcs multilib

MY_P=${P/_}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://sourceforge.net/projects/cracklib"
SRC_URI="mirror://sourceforge/cracklib/${MY_P}.tar.gz"

LICENSE="CRACKLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="nls python"

DEPEND="python? ( dev-lang/python )"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf \
		--with-default-dict='$(libdir)/cracklib_dict' \
		$(use_enable nls) \
		$(use_with python) \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm -r "${D}"/usr/share/cracklib

	# move shared libs to /
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)/ || die "could not move shared"
	gen_usr_ldscript libcrack.so

	insinto /usr/share/dict
	doins dicts/cracklib-small || die "word dict"

	dodoc AUTHORS ChangeLog NEWS README*
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		ebegin "Regenerating cracklib dictionary"
		create-cracklib-dict /usr/share/dict/* > /dev/null
		eend $?
	fi
}
