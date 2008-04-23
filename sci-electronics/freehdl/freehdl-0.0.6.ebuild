# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/freehdl/freehdl-0.0.6.ebuild,v 1.1 2008/04/23 08:56:29 calchan Exp $

DESCRIPTION="A free VHDL simulator."
SRC_URI="http://freehdl.seul.org/~enaroska/${P}.tar.gz"
HOMEPAGE="http://freehdl.seul.org/"
LICENSE="GPL-2"
DEPEND=">=sys-devel/gcc-3.4.3.20050110-r2
	dev-util/pkgconfig"
RDEPEND=">=dev-scheme/guile-1.3.1"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

src_install () {
	make DESTDIR="${D}" install || die "installation failed"
	dodoc AUTHORS ChangeLog HACKING NEWS README*
}
