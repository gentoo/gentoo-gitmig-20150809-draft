# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/gridlock/gridlock-1.6.1.ebuild,v 1.1 2003/07/17 17:08:48 brain Exp $

inherit gnustep

S=${WORKDIR}/${PN/g/G}
A=${PN/g/G}-GNUstep-${PV}.tar.gz

DESCRIPTION="Gridlock is a collection of grid-based games"
HOMEPAGE="http://dozingcat.com/"
SRC_URI="http://dozingcat.com/Gridlock/${PN/g/G}-GNUstep-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=dev-util/gnustep-gui-0.8.5"
