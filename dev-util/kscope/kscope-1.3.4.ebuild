# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kscope/kscope-1.3.4.ebuild,v 1.1 2006/04/20 02:53:28 flameeyes Exp $

inherit kde

DESCRIPTION="KScope is a KDE front-end to Cscope."
HOMEPAGE="http://kscope.sourceforge.net/"
SRC_URI="mirror://sourceforge/kscope/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/kate kde-base/kdebase )"
RDEPEND="${DEPEND}
	media-gfx/graphviz
	dev-util/ctags
	>=dev-util/cscope-15.5-r4"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

need-kde 3.2

src_install() {
	kde_src_install

	dodir /usr/share/applications/kde
	mv ${D}/usr/share/applnk/Development/kscope.desktop \
		${D}/usr/share/applications/kde

	insinto /usr/share/config
	doins "${FILESDIR}/${PN}rc"
}

