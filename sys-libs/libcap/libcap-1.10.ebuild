# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libcap/libcap-1.10.ebuild,v 1.15 2003/11/16 15:05:53 pappy Exp $

inherit base flag-o-matic

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="http://linux.kernel.org/pub/linux/libs/security/linux-privs/"
SRC_URI="http://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa arm amd64 ia64"
IUSE="python"

#patch is in recent 2.2 kernels so it works there
DEPEND="virtual/glibc
	virtual/os-headers
	python? ( >=virtual/python-2.2.1 >=dev-lang/swig-1.3.10 )"
RDEPEND="python? ( >=virtual/python-2.2.1 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# hardened-gcc needs this PIC patch to remove .TEXT relocations from the libcap library
	has_version "sys-devel/hardened-gcc" && epatch ${FILESDIR}/${PF}-syscall.patch
	epatch ${FILESDIR}/${PF}-python.patch
}

src_compile() {
	PYTHONVER="`python -V 2>&1 | sed 's/^Python //'|sed 's/\([0-9]*\.[0-9]*\).*/\1/'`"

	# filter-flags the PIC option only if hcc is not found active
	# and thats way the syscall removal patch will not be applied
	if ! has_version sys-devel/hardened-gcc
	then
		filter-flags -fPIC
	fi

	local myflags=""
	if [ `use python` ]; then
		myflags="${myflags} PYTHON=1 PYTHONMODDIR=/usr/lib/python${PYTHONVER}/site-packages"
		append-flags -I/usr/include/python${PYTHONVER}
	fi

	# http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml or #gentoo-hardened/irc.freenode
	has_version "sys-devel/hardened-gcc" && append-flags "-yet_exec"

	emake COPTFLAG="${CFLAGS}" DEBUG="" ${myflags} || die
}

src_install() {
	PYTHONVER="`python -V 2>&1 | sed 's/^Python //'|sed 's/\([0-9]*\.[0-9]*\).*/\1/'`"
	local myflags=""
	if [ `use python` ]; then
		myflags="${myflags} PYTHON=1 PYTHONMODDIR=${D}/usr/lib/python${PYTHONVER}/site-packages"

	fi
	make install FAKEROOT="${D}" man_prefix=/usr/share ${myflags} || die
	dodoc CHANGELOG README License pgp.keys.asc doc/capability.notes
}
