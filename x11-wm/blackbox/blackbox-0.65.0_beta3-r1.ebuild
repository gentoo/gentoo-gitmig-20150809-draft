# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.65.0_beta3-r1.ebuild,v 1.2 2002/08/14 15:27:51 murphy Exp $

inherit commonbox

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A small, fast, full-featured window manager for X"
SRC_URI="mirror://sourceforge/blackboxwm/${MY_P}.tar.gz"
HOMEPAGE="http://blackboxwm.sf.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

mydoc="AUTHORS LICENSE README ChangeLog* TODO*"

		
