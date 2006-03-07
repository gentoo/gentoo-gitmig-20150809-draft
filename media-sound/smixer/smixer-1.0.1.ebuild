# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/smixer/smixer-1.0.1.ebuild,v 1.16 2006/03/07 15:52:29 flameeyes Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="A command-line tool for setting and viewing mixer settings"
HOMEPAGE="http://centerclick.org/programs/smixer/"
SRC_URI="http://centerclick.org/programs/smixer/${PN}${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc hppa amd64 sparc"

S="${WORKDIR}/${PN}"

src_compile() {
	emake LD="$(tc-getCC)" CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" LFLAGS="${LDFLAGS}" || die
}

src_install () {
	dodir /usr/bin /etc /usr/share/man/man1

	make \
		INS_BIN=${D}/usr/bin \
		INS_ETC=${D}/etc \
		INS_MAN=${D}/usr/share/man/man1 \
		install || die

	dodoc README
}
