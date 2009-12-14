# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bashish/bashish-2.0.7-r1.ebuild,v 1.1 2009/12/14 12:03:01 jer Exp $

DESCRIPTION="Text console theme engine"
HOMEPAGE="http://bashish.sourceforge.net/"
SRC_URI="mirror://sourceforge/bashish/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-util/dialog-1.0"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	mv "${D}"/usr/share/doc/{${PN},${PF}} || die "mv docs failed"
}
