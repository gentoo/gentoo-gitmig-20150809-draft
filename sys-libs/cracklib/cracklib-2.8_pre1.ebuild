# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.8_pre1.ebuild,v 1.3 2005/02/22 22:30:12 vapier Exp $

inherit eutils

MY_P=${P/_}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://sourceforge.net/projects/cracklib"
SRC_URI="mirror://sourceforge/cracklib/${MY_P}.tar.gz"

LICENSE="CRACKLIB"
SLOT="0"
KEYWORDS="-*"
IUSE="minimal"

RDEPEND="sys-apps/miscfiles"
DEPEND="${RDEPEND}
	uclibc? ( app-arch/gzip )
	sys-devel/gcc-config"
PDEPEND="!minimal? ( sys-apps/cracklib-words )"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --disable-dependency-tracking || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -r "${D}"/usr/share/cracklib # remove the .magic file
	dodoc AUTHORS ChangeLog NEWS README*

	# move shared libs to /
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)/ || die "could not move shared"
	gen_usr_ldscript libcrack.so
}
