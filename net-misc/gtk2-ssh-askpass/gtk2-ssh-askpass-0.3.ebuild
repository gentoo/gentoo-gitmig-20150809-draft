# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtk2-ssh-askpass/gtk2-ssh-askpass-0.3.ebuild,v 1.1 2003/04/13 23:33:02 liquidx Exp $

DESCRIPTION="A small SSH Askpass replacement written with GTK2."
HOMEPAGE="http://www.cgabriel.org/sw/gtk2-ssh-askpass/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/x11
		>=x11-libs/gtk+-2.0"
S=${WORKDIR}/${P}

src_compile() {
		make || die "compile failed"
}

src_install() {
	dobin gtk2-ssh-askpass
	insinto /etc/env.d
	doins ${FILESDIR}/99ssh_askpass
	dodoc README AUTHORS
	doman debian/gtk2-ssh-askpass.1
}
