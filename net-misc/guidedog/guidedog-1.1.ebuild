# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guidedog/guidedog-1.1.ebuild,v 1.2 2009/11/26 20:51:02 maekke Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A network/routing configuration utility for KDE 4"
HOMEPAGE="http://www.simonzone.com/software/guidedog/"
SRC_URI="http://www.simonzone.com/software/guidedog/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug"

DEPEND="dev-python/PyQt4
	kde-base/pykde4
	!${CATEGORY}/${PN}:0"
RDEPEND="${DEPEND}
	net-firewall/iptables"

DOCS="AUTHORS ChangeLog README TODO"

src_install() {
	kde4-base_src_install
	rm -f "${D}"usr/share/apps/guidedog/*.pyc
	ln -nfs /usr/share/apps/guidedog/guidedog.py "${D}"usr/bin/guidedog || die
}
