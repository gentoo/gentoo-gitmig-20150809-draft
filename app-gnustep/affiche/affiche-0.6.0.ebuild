# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/affiche/affiche-0.6.0.ebuild,v 1.2 2003/07/28 06:52:56 phosphan Exp $

inherit gnustep

S=${WORKDIR}/${PN/a/A}
A=${P/a/A}.tar.gz

DESCRIPTION="Affiche allows people to 'stick' notes"
HOMEPAGE="http://www.collaboration-world.com/cgi-bin/collaboration-world/project/release.cgi?pid=5"
SRC_URI="http://www.collaboration-world.com/affiche.data/releases/Stable/${P/a/A}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=dev-util/gnustep-gui-0.8.5"
