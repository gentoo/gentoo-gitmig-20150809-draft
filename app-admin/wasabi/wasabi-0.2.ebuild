# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/wasabi/wasabi-0.2.ebuild,v 1.1 2004/06/20 23:47:07 ciaranm Exp $

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://www.gentoo.org/~lcars/wasabi"
SRC_URI="http://www.gentoo.org/~lcars/wasabi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

RDEPEND="sys-apps/coreutils"

src_install() {
	emake DESTDIR=${D} install
	doman wasabi.8
	exeinto /etc/init.d
	newexe wasabi.init wasabi
}
