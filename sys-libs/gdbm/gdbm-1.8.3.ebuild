# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.3.ebuild,v 1.7 2004/04/27 05:32:49 vapier Exp $

inherit gnuconfig eutils flag-o-matic

DESCRIPTION="Standard GNU database libraries included for compatibility with Perl"
HOMEPAGE="http://www.gnu.org/software/gdbm/gdbm.html"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha arm ~hppa ~amd64 ~ia64 ppc64"
IUSE="berkdb static"

DEPEND="virtual/glibc
	berkdb? ( =sys-libs/db-1* )"
RDEPEND="virtual/glibc"

src_compile() {
	gnuconfig_update

	! is-flag "-fomit-frame-pointer" && append-flags "-fomit-frame-pointer"

	local myconf
	use static && myconf="${myconf} --enable-static"

	econf ${myconf} || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die

	make \
		includedir=/usr/include/gdbm \
		INSTALL_ROOT=${D} \
		install-compat || die

	dosed "s:/usr/local/lib':/usr/lib':g" /usr/lib/libgdbm.la

	dodoc ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "Please run revdep-rebuild --soname libgdbm.so"
	ewarn "Because things compiled against the previous version will not"
	ewarn "work"
}
