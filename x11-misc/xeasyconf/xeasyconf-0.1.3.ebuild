# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xeasyconf/xeasyconf-0.1.3.ebuild,v 1.7 2003/09/05 23:18:18 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Xeasyconf is a PPC only tool to assist in xfree 4.x configs"
SRC_URI="http://gentoo.org/~gerk/xeasyconf/${P}.tar.gz"
HOMEPAGE="http://gentoo.org/~gerk/xeasyconf/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc -x86 -sparc  -alpha"

DEPEND="x11-base/xfree
	sys-apps/pciutils"
RDEPEND="dev-util/dialog"

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
