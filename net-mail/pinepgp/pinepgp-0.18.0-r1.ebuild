# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pinepgp/pinepgp-0.18.0-r1.ebuild,v 1.7 2004/03/23 19:02:24 mholzer Exp $

DESCRIPTION="Use GPG/PGP with Pine"
HOMEPAGE="http://www.megaloman.com/~hany/software/pinepgp/"
SRC_URI="http://www.megaloman.com/~hany/_data/pinepgp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="net-mail/pine app-crypt/gnupg"

S="${WORKDIR}/${P}"

src_compile()	{
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install()	{
	make DESTDIR=${D} install || die "install problem"
	dodoc ChangeLog COPYING README
}

