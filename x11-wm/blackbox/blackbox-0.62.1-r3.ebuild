# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.62.1-r3.ebuild,v 1.5 2002/10/05 05:39:28 drobbins Exp $

IUSE="nls"

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="A small, fast, full-featured window manager for X"
SRC_URI="mirror://sourceforge/blackboxwm/${P}.tar.gz"
HOMEPAGE="http://blackboxwm.sf.net/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

mydoc="ChangeLog* LICENSE TODO*"
