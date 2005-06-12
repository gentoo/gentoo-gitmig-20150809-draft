# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/cputnik/cputnik-0.1.1.ebuild,v 1.3 2005/06/12 19:24:11 josejx Exp $

inherit eutils

IUSE=""

DESCRIPTION="cputnik is a simple cpu monitor dockapp."
HOMEPAGE="http://clay.ll.pl/projects.html#dockapps"
SRC_URI="http://clay.ll.pl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"

DEPEND="virtual/x11"

src_compile()
{
	make CFLAGS="${CFLAGS} -Iwmgeneral" || die "Compilation failed"
}

src_install()
{
	dobin cputnik
	dodoc AUTHORS Changelog README
}
