# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/pantomime/pantomime-1.1.0_pre2.ebuild,v 1.8 2004/07/22 21:44:05 fafhrd Exp $

inherit base gnustep-old

DESCRIPTION="A set of Objective-C classes that model a mail system"
HOMEPAGE="http://www.collaboration-world.com/pantomime/"
LICENSE="LGPL-2.1"
SRC_URI="http://www.collaboration-world.com/pantomime.data/releases/Stable/${PN/p/P}-${PV/_/}.tar.gz"
KEYWORDS="x86 ~ppc ~alpha"
SLOT="0"
S=${WORKDIR}/${PN/p/P}
PATCHES="${FILESDIR}/${P}-compilation-fix.diff"
IUSE=""
