# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tktable/tktable-2.9.ebuild,v 1.3 2004/11/06 15:41:39 pyrania Exp $

MY_P="Tktable${PV}"
DESCRIPTION="full-featured 2D table widget"
HOMEPAGE="http://tktable.sourceforge.net/"
SRC_URI="mirror://sourceforge/tktable/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/tk-8.0"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
