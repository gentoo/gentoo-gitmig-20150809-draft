# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.3-r2.ebuild,v 1.6 2006/10/17 08:29:30 uberlord Exp $

inherit eutils libtool multilib

DESCRIPTION="Standard GNU database libraries included for compatibility with Perl"
HOMEPAGE="http://www.gnu.org/software/gdbm/gdbm.html"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc-macos ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="berkdb"

DEPEND="berkdb? ( sys-libs/db )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix-install-ownership.patch #24178
	elibtoolize
}

src_compile() {
	use berkdb || export ac_cv_lib_dbm_main=no ac_cv_lib_ndbm_main=no
	econf --includedir=/usr/include/gdbm || die
	emake || die
}

src_install() {
	make INSTALL_ROOT="${D}" install install-compat || die
	mv "${D}"/usr/include/gdbm/gdbm.h "${D}"/usr/include/ || die
	dodoc ChangeLog NEWS README
}

pkg_preinst() {
	# temp backwards support #32510
	if [[ -e ${ROOT}/usr/$(get_libdir)/libgdbm.so.2 ]] ; then
		touch "${ROOT}"/usr/$(get_libdir)/libgdbm.so.2
	fi
}

pkg_postinst() {
	if [[ -e ${ROOT}/usr/$(get_libdir)/libgdbm.so.2 ]] ; then
		ewarn "Please run revdep-rebuild --library libgdbm.so.2"
		ewarn "After that completes, it will be safe to remove the old"
		ewarn "library (${ROOT}usr/$(get_libdir)/libgdbm.so.2)."
	fi
}
