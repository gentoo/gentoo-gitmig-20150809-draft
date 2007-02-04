# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sary/sary-1.2.0.ebuild,v 1.15 2007/02/04 05:19:39 beandog Exp $

IUSE=""

DESCRIPTION="Sary: suffix array library and tools"
HOMEPAGE="http://sary.sourceforge.net/"
SRC_URI="http://sary.sourceforge.net/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc-macos ppc64 sparc x86"
SLOT="0"
RESTRICT="test"

RDEPEND=">=dev-libs/glib-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {

	make DESTDIR="${D}" \
		docsdir=/usr/share/doc/${PF}/html \
		install || die

	dodoc [A-Z][A-Z]* ChangeLog

}
