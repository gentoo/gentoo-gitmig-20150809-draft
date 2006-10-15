# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkacpi/gkacpi-2.0.4.ebuild,v 1.1 2006/10/15 23:20:57 bass Exp $

IUSE=""
DESCRIPTION="ACPI monitor for Gkrellm"
SRC_URI="mirror://sourceforge/gkacpi/${PN}2-0.4.tar.gz"
HOMEPAGE="http://gkacpi.sf.net"
LICENSE="GPL-2"
DEPEND="dev-util/pkgconfig"
RDEPEND="${DEPEND}
	=app-admin/gkrellm-2*"
KEYWORDS="~x86"
SLOT="0"

S="${WORKDIR}/${PN}2-0.4"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins gkacpi2.so

	dodoc AUTHORS ChangeLog COPYING INSTALL README
}
