# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kscope/kscope-0.8.ebuild,v 1.2 2004/08/04 09:33:41 dholm Exp $

inherit kde

DESCRIPTION="KScope is a KDE front-end to Cscope."
HOMEPAGE="http://kscope.sourceforge.net/"
SRC_URI="mirror://sourceforge/kscope/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="dev-util/ctags
	>=dev-util/cscope-15.5"

need-kde 3.2