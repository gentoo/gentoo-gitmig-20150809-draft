# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libcap/libcap-1.10-r5.ebuild,v 1.5 2007/02/10 00:32:57 vapier Exp $

inherit flag-o-matic eutils

DEB_PVER=14
DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="http://www.kernel.org/pub/linux/libs/security/linux-privs/"
SRC_URI="http://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/${P}.tar.bz2
	mirror://debian/pool/main/libc/libcap/libcap_${PV}-${DEB_PVER}.diff.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="nocxx python static"

#patch is in recent 2.2 kernels so it works there
DEPEND="virtual/os-headers
	!nocxx? ( python? ( >=virtual/python-2.2.1 >=dev-lang/swig-1.3.10 ) )"
RDEPEND="!nocxx? ( python? ( >=virtual/python-2.2.1 ) )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/libcap_${PV}-${DEB_PVER}.diff
	epatch ${FILESDIR}/${PV}-python.patch
	epatch ${FILESDIR}/libcap-1.10-r4-staticfix.diff
	sed -i 's|WARNINGS=-ansi|WARNINGS=|' Make.Rules
}

src_compile() {
	local PYTHONVER="`python -V 2>&1 | sed 's/^Python //'|sed 's/\([0-9]*\.[0-9]*\).*/\1/'`"
	local myflags=""
	use static && CFLAGS="${CFLAGS} -static" && LDFLAGS="${LDFLAGS} -static"
	if ! use nocxx && use python ; then
		myflags="${myflags} PYTHON=1 PYTHONMODDIR=/usr/$(get_libdir)/python${PYTHONVER}/site-packages"
		append-flags -I/usr/include/python${PYTHONVER}
	fi

	emake COPTFLAG="${CFLAGS}" LDFLAGS="${LDFLAGS}" DEBUG="" ${myflags} || die
}

src_install() {
	local PYTHONVER="`python -V 2>&1 | sed 's/^Python //'|sed 's/\([0-9]*\.[0-9]*\).*/\1/'`"
	local myflags=""
	if ! use nocxx && use python ; then
		myflags="${myflags} PYTHON=1 PYTHONMODDIR=${D}/usr/$(get_libdir)/python${PYTHONVER}/site-packages"
	fi
	make install FAKEROOT="${D}" man_prefix=/usr/share LIBDIR="${D}/$(get_libdir)" ${myflags} || die
	dodir /usr/$(get_libdir)
	mv "${D}"/$(get_libdir)/libcap.a "${D}"/usr/$(get_libdir)
	gen_usr_ldscript libcap.so
	dodoc CHANGELOG README pgp.keys.asc doc/capability.notes capfaq-0.2.txt
}
