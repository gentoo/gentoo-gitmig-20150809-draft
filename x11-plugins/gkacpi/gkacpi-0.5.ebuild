# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkacpi/gkacpi-0.5.ebuild,v 1.6 2004/03/26 23:10:05 aliz Exp $

IUSE=""
DESCRIPTION="ACPI monitor for Gkrellm"
SRC_URI="http://uname.dyndns.org/~uname/files/gkacpi/${P}.tar.gz"
HOMEPAGE="http://uname.dyndns.org/~uname/software.php"
LICENSE="GPL-2"
DEPEND="=app-admin/gkrellm-2*"
RDEPEND="${DEPEND}"
KEYWORDS="x86"
SLOT="0"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins gkacpi.so

	dodoc AUTHORS ChangeLog COPYING INSTALL README
}
