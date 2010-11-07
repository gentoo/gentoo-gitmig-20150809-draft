# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cssc/cssc-1.0.1.ebuild,v 1.4 2010/11/07 19:22:17 jer Exp $

# leave this ebuild around please, it's the only one that compiles (and hence
# isn't masked) -- grobian

EAPI="3"

DESCRIPTION="CSSC is the GNU Project's replacement for SCCS"
SRC_URI="mirror://sourceforge/cssc/CSSC-${PV}.tar.gz"
HOMEPAGE="http://cssc.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
S=${WORKDIR}/CSSC-${PV}
KEYWORDS="~ppc-macos ~x86-macos"
IUSE=""
RESTRICT="test"

src_configure() {
	econf --enable-binary || die
}

src_compile() {
	emake all || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc README NEWS ChangeLog AUTHORS
}
