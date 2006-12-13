# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtk2-ssh-askpass/gtk2-ssh-askpass-0.3.ebuild,v 1.16 2006/12/13 19:52:32 uberlord Exp $

DESCRIPTION="A small SSH Askpass replacement written with GTK2."
HOMEPAGE="https://www.cgabriel.org/software/wiki/SshAskpassFullscreen"
SRC_URI="http://www.cgabriel.org/sw/ssh-askpass-fullscreen/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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
