# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qof/qof-0.7.2.ebuild,v 1.4 2007/10/23 14:16:32 armin76 Exp $

DESCRIPTION="A Query Object Framework"
HOMEPAGE="http://qof.sourceforge.net/"
SRC_URI="mirror://sourceforge/qof/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~ppc64 ~sparc ~x86"

IUSE=""

DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die
}
