# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Addme please

MY_PN=linux-coda
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="Kernel module for the Coda Filesystem. The stock module will not work for Coda versions 6.0 and above."
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/coda/linux/kernel/${MY_P}.tgz"

RESTRICT="nostrip"

SLOT="${KV}"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
IUSE=""

DEPEND=">=virtual/linux-sources-2.4"


src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix retarded Configure script.  Have the coda developers actually seen
	# a 2.4 kernel source tree before?
	sed -i 's:MODVER="$LINUX:MODVER="$LINUX/include/linux:' Configure
}

src_compile() {
	# Why does everything about Coda have to be different?
	# Why use 'Configure' when everyone else on earth uses 'configure'... 0_o
	./Configure --srctree --kernel=/usr/src/linux --noprompt || die

	# Must unset the CFLAGS or we trigger an ifdef in the Makefile which causes
	# the module to not build correctly. ;|
	unset CFLAGS
	make coda.o || die "make failed"
}

src_install() {
	einstall MODDIR="${D}/lib/modules/${KV}"
}

pkg_postinst() {
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
}
