# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-6.1.ebuild,v 1.11 2004/12/07 03:56:43 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="GNU debugger"
HOMEPAGE="http://sources.redhat.com/gdb/"
SRC_URI="http://mirrors.rcn.net/pub/sourceware/gdb/releases/${P}.tar.bz2
	mirror://gentoo/gdb-6.1-hppa-01.patch.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~hppa ppc64 s390 ~x86"
IUSE="nls makecheck"

RDEPEND=">=sys-libs/ncurses-5.2-r2"
DEPEND="${RDEPEND}
	makecheck? ( dev-util/dejagnu )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gdb-6.1-ppc64-01.patch
	epatch ${WORKDIR}/gdb-6.1-hppa-01.patch
	epatch ${FILESDIR}/gdb-6.1-uclibc.patch
}

src_compile() {
	replace-flags -O? -O2
	econf $(use_enable nls) || die
	make || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/$(get_libdir) \
		infodir=${D}/usr/share/info \
		install || die "install"
	dodoc README
	docinto gdb
	dodoc gdb/CONTRIBUTE gdb/README gdb/MAINTAINERS \
		gdb/NEWS gdb/ChangeLog* gdb/TODO
	docinto sim
	dodoc sim/ChangeLog sim/MAINTAINERS sim/README-HACKING
	docinto mmalloc
	dodoc mmalloc/MAINTAINERS mmalloc/ChangeLog mmalloc/TODO

	if ! has noinfo ${FEATURES} ; then
		cd gdb/doc
		make \
			infodir=${D}/usr/share/info \
			install-info || die "install doc info"

		cd ${S}/bfd/doc
		make \
			infodir=${D}/usr/share/info \
			install-info || die "install bfd info"
	fi

	# These includes and libs are in binutils already
	rm -f ${D}/usr/lib/libbfd.*
	rm -f ${D}/usr/lib/libiberty.*
	rm -f ${D}/usr/lib/libopcodes.*
	rm -f ${D}/usr/share/info/{bfd,configure,standards}.info*
	rm -r ${D}/usr/share/locale
	rm -r ${D}/usr/include
}
