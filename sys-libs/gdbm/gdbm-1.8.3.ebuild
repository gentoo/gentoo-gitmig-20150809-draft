# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.3.ebuild,v 1.3 2003/12/17 04:19:55 brad_mssw Exp $

inherit gnuconfig eutils flag-o-matic

IUSE="berkdb static"

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU database libraries included for compatibility with Perl"
HOMEPAGE="http://www.gnu.org/software/gdbm/gdbm.html"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm ~ia64 ppc64"

DEPEND="virtual/glibc
	berkdb? ( amd64? sys-libs/db : =sys-libs/db-1.85-r1 )"

RDEPEND="virtual/glibc"

src_compile() {
	use alpha && gnuconfig_update
	use arm && gnuconfig_update
	use hppa && gnuconfig_update
	use amd64 && gnuconfig_update
	use ia64 && gnuconfig_update

	if [ ! `is-flag "-fomit-frame-pointer"` ]
	then
		append-flags "-fomit-frame-pointer"
	fi

	local myconf

	use static && myconf="${myconf} --enable-static"

	econf ${myconf} || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {

	make INSTALL_ROOT=${D} install || die

	make includedir=/usr/include/gdbm \
		INSTALL_ROOT=${D} \
		install-compat || die

	dosed "s:/usr/local/lib':/usr/lib':g" /usr/lib/libgdbm.la

	dodoc COPYING ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "Please run revdep-rebuild --soname libgdbm.so"
	ewarn "Because things compiled against the previous version will not"
	ewarn "work"
}
