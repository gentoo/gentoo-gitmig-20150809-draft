# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.3.ebuild,v 1.11 2004/07/24 06:57:17 vapier Exp $

inherit gnuconfig flag-o-matic

DESCRIPTION="Standard GNU database libraries included for compatibility with Perl"
HOMEPAGE="http://www.gnu.org/software/gdbm/gdbm.html"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha arm ~hppa amd64 ~ia64 ppc64"
IUSE="berkdb static"

DEPEND="virtual/libc
	berkdb? ( =sys-libs/db-1* )"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_compile() {
	append-flags -fomit-frame-pointer
	econf || die
	use berkdb || sed -i '/HAVE_LIBNDBM/s:.*::' autoconf.h
	emake || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die

	make \
		includedir=/usr/include/gdbm \
		INSTALL_ROOT=${D} \
		install-compat || die

	dodoc ChangeLog NEWS README

	# temp backwards support #32510
	if [ -e ${ROOT}/usr/lib/libgdbm.so.2 ] ; then
		cp -a ${ROOT}/usr/lib/libgdbm.so.2 ${D}/usr/lib/
	fi
}

pkg_postinst() {
	ewarn "Please run revdep-rebuild --soname libgdbm.so"
	ewarn "Packages compiled against the previous version will not work"
}
