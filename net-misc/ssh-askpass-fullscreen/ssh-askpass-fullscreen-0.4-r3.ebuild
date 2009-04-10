# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ssh-askpass-fullscreen/ssh-askpass-fullscreen-0.4-r3.ebuild,v 1.3 2009/04/10 13:27:22 armin76 Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A small SSH Askpass replacement written with GTK2."
HOMEPAGE="https://www.cgabriel.org/software/wiki/SshAskpassFullscreen"
SRC_URI="http://www.cgabriel.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
	!net-misc/gtk2-ssh-askpass"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e '2 s/$/$\(LDFLAGS\)/' Makefile || die "sed failed"
	sed -i -e "s:gcc:$(tc-getCC) ${CFLAGS}:g" Makefile || die "sed failed"
	epatch "${FILESDIR}/${P}-fix-grab.patch"
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}" || die "compile failed"
}

src_install() {
	dobin ssh-askpass-fullscreen || die "dobin failed"
	echo "SSH_ASKPASS=/usr/bin/ssh-askpass-fullscreen" >> "${T}/99ssh_askpass" \
		|| die "envd file creation failed"
	doenvd "${T}"/99ssh_askpass || die "doenvd failed"
	dodoc README AUTHORS ChangeLog || die "missing docs"
	doman "${FILESDIR}"/ssh-askpass-fullscreen.1 || die "man page failed"
}
