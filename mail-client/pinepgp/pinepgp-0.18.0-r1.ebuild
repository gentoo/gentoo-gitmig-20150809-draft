# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/pinepgp/pinepgp-0.18.0-r1.ebuild,v 1.3 2004/06/04 09:08:22 dholm Exp $

DESCRIPTION="Use GPG/PGP with Pine"
HOMEPAGE="http://www.megaloman.com/~hany/software/pinepgp/"
SRC_URI="http://www.megaloman.com/~hany/_data/pinepgp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="mail-client/pine app-crypt/gnupg"

S="${WORKDIR}/${P}"

src_compile()	{
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install()	{
	make DESTDIR=${D} install || die "install problem"
	dodoc ChangeLog COPYING README
}

