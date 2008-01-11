# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kscope/kscope-1.6.1.ebuild,v 1.1 2008/01/11 14:29:10 carlo Exp $

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

need-kde 3.5

PATCHES="${FILESDIR}/kscope-1.6.1-desktop-entry.diff"

src_install() {
	kde_src_install

	insinto /usr/share/config
	doins "${FILESDIR}/${PN}rc"
}
