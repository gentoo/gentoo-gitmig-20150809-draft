# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ld.so/ld.so-1.9.11-r3.ebuild,v 1.5 2003/09/08 08:25:07 vapier Exp $

DESCRIPTION="Linux dynamic loader & linker"
HOMEPAGE="http://freshmeat.net/projects/ld.so/"
SRC_URI="x86? ( ftp://ftp.ods.com/pub/linux/${P}.tar.gz )"

LICENSE="LD.SO"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND="sys-libs/lib-compat"

src_unpack() {
	[ "${ARCH}" != "x86" ] && return 0
	unpack ${A}
	cd ${S}
	sed -i "s:usr/man:usr/share/man:g" instldso.sh
}

src_install() {
	[ "${ARCH}" != "x86" ] && return 0
	PREFIX=${D} ./instldso.sh --force

	# Remove stuff that comes with glibc
	rm -rf ${D}/sbin ${D}/usr/bin
	rm ${D}/usr/share/man/man8/ldconfig*

	preplib /

	dodoc COPYRIGHT README ld-so/example/README*
}
