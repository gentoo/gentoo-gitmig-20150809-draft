# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/pantomime/pantomime-1.1.0.ebuild,v 1.1 2003/08/21 08:43:27 g2boojum Exp $

inherit base gnustep

DESCRIPTION="A set of Objective-C classes that model a mail system"
HOMEPAGE="http://www.collaboration-world.com/pantomime/"
LICENSE="LGPL-2.1"
SRC_URI="http://www.collaboration-world.com/pantomime.data/releases/Stable/${PN/p/P}-${PV}.tar.gz"
KEYWORDS="~x86 ~ppc"
SLOT="0"
S=${WORKDIR}/${PN/p/P}
