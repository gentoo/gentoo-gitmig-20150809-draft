# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/pantomime/pantomime-1.1.0_pre2.ebuild,v 1.1 2003/07/15 08:09:24 raker Exp $

inherit gnustep

DESCRIPTION="A set of Objective-C classes that model a mail system"
HOMEPAGE="http://www.collaboration-world.com/pantomime/"
LICENSE="LGPL"
SRC_URI="http://www.collaboration-world.com/pantomime.data/releases/Stable/${PN/p/P}-${PV/_/}.tar.gz"
KEYWORDS="x86"
SLOT="0"
S=${WORKDIR}/${PN/p/P}
