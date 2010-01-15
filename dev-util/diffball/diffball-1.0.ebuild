# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffball/diffball-1.0.ebuild,v 1.11 2010/01/15 21:32:22 fauli Exp $

DESCRIPTION="Delta compression suite for using/generating binary patches"
HOMEPAGE="http://developer.berlios.de/projects/diffball/"
SRC_URI="mirror://berlios/diffball/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 mips ppc ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="debug"

DEPEND=">=sys-libs/zlib-1.1.4
	>=app-arch/bzip2-1.0.2"

# Invalid RESTRICT for source package. Investigate.
RESTRICT="strip"

src_compile() {
	econf $(use_enable debug asserts)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
