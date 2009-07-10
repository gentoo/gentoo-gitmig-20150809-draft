# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/freehdl/freehdl-0.0.7.ebuild,v 1.1 2009/07/10 17:09:17 calchan Exp $

DESCRIPTION="A free VHDL simulator."
SRC_URI="http://freehdl.seul.org/~enaroska/${P}.tar.gz"
HOMEPAGE="http://freehdl.seul.org/"
LICENSE="GPL-2"

CDEPEND="dev-lang/perl"
DEPEND="${CDEPEND}
	dev-util/pkgconfig"
RDEPEND="${CDEPEND}
	>=dev-scheme/guile-1.3.1"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

src_install () {
	make DESTDIR="${D}" install || die "installation failed"
	dodoc AUTHORS ChangeLog HACKING NEWS README*
}
