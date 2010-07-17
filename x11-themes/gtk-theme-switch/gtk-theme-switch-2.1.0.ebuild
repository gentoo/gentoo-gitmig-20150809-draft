# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-theme-switch/gtk-theme-switch-2.1.0.ebuild,v 1.7 2010/07/17 17:30:10 armin76 Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Utility to switch and preview GTK+ theme"
HOMEPAGE="http://packages.qa.debian.org/g/gtk-theme-switch.html"
SRC_URI="mirror://debian/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e 's:${GCC}:$(CC) $(LDFLAGS):' \
		Makefile || die
}

src_compile() {
	tc-export CC
	emake CFLAGS="${CFLAGS} -Wall" || die
}

src_install() {
	newbin ${PN}2 ${PN} || die
	newman ${PN}2.1 ${PN}.1 || die
	dodoc ChangeLog readme todo
}
