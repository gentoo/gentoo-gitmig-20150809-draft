# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.0-r5.ebuild,v 1.28 2003/12/17 20:13:50 brad_mssw Exp $

inherit gnuconfig eutils flag-o-matic

IUSE="berkdb static"

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU database libraries included for compatibility with Perl"
HOMEPAGE="http://www.gnu.org/software/gdbm/gdbm.html"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa arm ia64 ppc64"

DEPEND="virtual/glibc
	berkdb? ( amd64? sys-libs/db : =sys-libs/db-1.85-r1 )"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	use alpha && gnuconfig_update
	use arm && gnuconfig_update
	use hppa && gnuconfig_update
	use amd64 && gnuconfig_update
	use ia64 && gnuconfig_update
}

src_compile() {


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

	einstall \
		man3dir=${D}/usr/share/man/man3 || die

	make includedir=${D}/usr/include/gdbm \
		install-compat || die

	dosed "s:/usr/local/lib':/usr/lib':g" /usr/lib/libgdbm.la

	dodoc COPYING ChangeLog NEWS README
}
