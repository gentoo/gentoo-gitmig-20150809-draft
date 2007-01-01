# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ledit/ledit-1.11-r1.ebuild,v 1.3 2007/01/01 21:29:55 ticho Exp $

inherit eutils

IUSE=""

DESCRIPTION="A line editor to be used with interactive commands."
SRC_URI="ftp://ftp.inria.fr/INRIA/Projects/cristal/Daniel.de_Rauglaudre/Tools/${P}.tar.gz"
HOMEPAGE="http://caml.inria.fr/cgi-bin/hump.en.cgi?contrib=301"

DEPEND=">=dev-lang/ocaml-3.09"
RDEPEND=""

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc x86"

src_compile()
{
	epatch "${FILESDIR}/${P}-loc.patch" || die "patch failed"
	make || die "make failed"
	make ledit.opt || die "make failed"
}

src_install()
{
	newbin ledit.opt ledit
	newman ledit.l ledit.1
	dodoc Changes LICENSE README
}
