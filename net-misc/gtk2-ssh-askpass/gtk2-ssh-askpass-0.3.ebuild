# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtk2-ssh-askpass/gtk2-ssh-askpass-0.3.ebuild,v 1.8 2004/07/15 02:50:34 agriffis Exp $

DESCRIPTION="A small SSH Askpass replacement written with GTK2."
HOMEPAGE="http://www.cgabriel.org/sw/gtk2-ssh-askpass/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha ~ia64 ~amd64"
IUSE=""
DEPEND="virtual/x11
		>=x11-libs/gtk+-2.0"

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
