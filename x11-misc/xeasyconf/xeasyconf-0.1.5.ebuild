# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xeasyconf/xeasyconf-0.1.5.ebuild,v 1.8 2004/06/24 22:40:18 agriffis Exp $

IUSE=""

DESCRIPTION="Xeasyconf is a PPC only tool to assist in xfree 4.x configs"
SRC_URI="http://gentoo.macdiscussion.com/xeasyconf/${P}.tar.gz"
HOMEPAGE="http://gentoo.macdiscussion.com/xeasyconf/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc -x86 -sparc -alpha"

DEPEND="virtual/x11
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
