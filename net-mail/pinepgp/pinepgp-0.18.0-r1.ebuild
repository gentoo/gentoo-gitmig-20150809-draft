# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/pinepgp/pinepgp-0.18.0-r1.ebuild,v 1.1 2002/08/14 19:27:54 blizzy Exp $

DESCRIPTION="Use GPG/PGP with Pine"
HOMEPAGE="http://www.megaloman.com/~hany/software/pinepgp/"
SRC_URI="http://www.megaloman.com/~hany/_data/pinepgp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="net-mail/pine"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_compile()	{
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install()	{
	make DESTDIR=${D} install || die "install problem"
	dodoc ChangeLog COPYING README
}

