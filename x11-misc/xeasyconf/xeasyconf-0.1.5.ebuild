# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xeasyconf/xeasyconf-0.1.5.ebuild,v 1.4 2003/09/05 23:18:18 msterret Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Xeasyconf is a PPC only tool to assist in xfree 4.x configs"
SRC_URI="http://gentoo.macdiscussion.com/xeasyconf/${P}.tar.gz"
HOMEPAGE="http://gentoo.macdiscussion.com/xeasyconf/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc -x86 -sparc  -alpha"

DEPEND="x11-base/xfree
	sys-apps/pciutils"
RDEPEND="dev-util/dialog"

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
