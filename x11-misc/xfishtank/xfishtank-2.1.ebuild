# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfishtank/xfishtank-2.1.ebuild,v 1.1 2004/04/12 20:17:10 pyrania Exp $

DESCRIPTION="Turns your root window into an aquarium."
HOMEPAGE="http://www.ibiblio.org/pub/Linux/X11/demos/"
MY_P="${P}tp"
SRC_URI="${HOMEPAGE}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/x11"

src_compile() {
	makedepend || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc README.Linux README.TrueColor README.Why2.1tp
}
