# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.0-r5.ebuild,v 1.35 2004/07/02 08:45:11 eradicator Exp $

inherit gnuconfig eutils flag-o-matic

DESCRIPTION="Standard GNU database libraries included for compatibility with Perl"
HOMEPAGE="http://www.gnu.org/software/gdbm/gdbm.html"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="berkdb static"

DEPEND="virtual/libc
	berkdb? ( =sys-libs/db-1.85-r1 )"

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	gnuconfig_update
}

src_compile() {
	! is-flag "-fomit-frame-pointer" && append-flags "-fomit-frame-pointer"

	local myconf

	use static && myconf="${myconf} --enable-static"

	econf ${myconf} || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	einstall \
		man3dir=${D}/usr/share/man/man3 || die

	make includedir=${D}/usr/include/gdbm \
		install-compat || die

	dosed "s:/usr/local/lib':/usr/lib':g" /usr/lib/libgdbm.la

	dodoc ChangeLog NEWS README
}
