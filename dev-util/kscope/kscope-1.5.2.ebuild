# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kscope/kscope-1.5.2.ebuild,v 1.2 2007/07/12 01:05:42 mr_bones_ Exp $

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

	insinto /usr/share/config
	doins "${FILESDIR}/${PN}rc"
}
