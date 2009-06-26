# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kscope/kscope-1.6.2.ebuild,v 1.2 2009/06/26 11:27:10 scarabeus Exp $

EAPI=1
ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KScope is a KDE front-end to Cscope."
HOMEPAGE="http://kscope.sourceforge.net/"
SRC_URI="mirror://sourceforge/kscope/${P}.tar.gz"

SLOT="3.5"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/kate:3.5 kde-base/kdebase:3.5 )"
RDEPEND="${DEPEND}
	media-gfx/graphviz
	dev-util/ctags
	>=dev-util/cscope-15.5-r4"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

need-kde 3.5

PATCHES="${FILESDIR}/kscope-1.6.1-desktop-entry.diff"

src_unpack() {
	kde_src_unpack
	rm -f "${S}/configure"
}

src_install() {
	kde_src_install

	insinto /usr/share/config
	doins "${FILESDIR}/${PN}rc"
}
