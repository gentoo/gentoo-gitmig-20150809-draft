# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xeasyconf/xeasyconf-0.1.3.ebuild,v 1.1 2002/08/25 02:49:21 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Xeasyconf is a PPC only tool to assist in xfree 4.x configs"
SRC_URI="http://gentoo.org/~gerk/xeasyconf/${P}.tar.gz"
HOMEPAGE="http://gentoo.org/~gerk/xeasyconf/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc -x86 -sparc -sparc64"

DEPEND="virtual/glibc x11-base/xfree sys-apps/pciutils dev-util/dialog"


src_unpack() {

	if [ ${ARCH} != ppc ]
	then 
		die "This is a PPC-only package, sorry"
	fi

	unpack ${A}
	cd ${S}
}

src_compile() {

	make || die "sorry, failed to compile"
}

src_install() {
	
	dodir /usr/bin/
	dodir /usr/sbin/
	into /usr/
	dobin fbcheck
	into /usr/
	dosbin Xeasyconf

}
