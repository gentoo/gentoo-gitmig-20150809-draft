# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kscope/kscope-1.2.0.ebuild,v 1.6 2006/03/08 17:23:41 carlo Exp $

inherit kde

DESCRIPTION="KScope is a KDE front-end to Cscope."
HOMEPAGE="http://kscope.sourceforge.net/"
SRC_URI="mirror://sourceforge/kscope/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="|| ( kde-base/kate kde-base/kdebase)"
RDEPEND="${DEPEND}
	dev-util/ctags
	>=dev-util/cscope-15.5-r4"

need-kde 3.2
