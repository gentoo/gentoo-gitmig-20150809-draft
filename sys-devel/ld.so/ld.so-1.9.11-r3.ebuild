# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ld.so/ld.so-1.9.11-r3.ebuild,v 1.4 2003/02/13 16:33:07 vapier Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Linux dynamic loader & linker"
SRC_URI="x86? ( ftp://ftp.ods.com/pub/linux/${P}.tar.gz )"
HOMEPAGE="http://freshmeat.net/projects/ld.so/"

RDEPEND="sys-libs/lib-compat"

LICENSE="LD.SO"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

src_unpack() {

	if [ "${ARCH}" = "x86" ]
	then
		unpack ${A}
		
		cd ${S}
		cp instldso.sh instldso.orig
		sed -e "s:usr/man:usr/share/man:g" \
		    instldso.orig > instldso.sh
	fi
}

src_install() {

	if [ "${ARCH}" = "x86" ]
	then
		PREFIX=${D} ./instldso.sh --force

		# Remove stuff that comes with glibc
		rm -rf ${D}/sbin ${D}/usr/bin
		rm ${D}/usr/share/man/man8/ldconfig*

		preplib /

		dodoc COPYRIGHT README ld-so/example/README*
	fi
}

