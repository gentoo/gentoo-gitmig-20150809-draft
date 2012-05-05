# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/apwal/apwal-0.4.5.ebuild,v 1.7 2012/05/05 04:53:44 jdhore Exp $

EAPI=2

DESCRIPTION="A simple application launcher and combined editor"
HOMEPAGE="http://apwal.free.fr/"
SRC_URI="http://apwal.free.fr/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

src_prepare() {
	# ugly hardcoded cflags
	# and prevent strip
	sed -i \
		-e "s:-O2:${CFLAGS}:" \
		-e "/strip/d" src/Makefile \
			|| die "sed src/Makefile failed"
	# make parallel make happy
	sed -i \
		-e "/cd src/ c\	\$(MAKE) -C src \$@" Makefile \
			|| die "sed Makefile failed"
}

src_install() {
	dobin src/apwal || die "dobin failed"
	dosym apwal /usr/bin/apwal-editor || die "dosym failed"
	dodoc ABOUT Changelog FAQ README  || die "dodoc failed"
}
