# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $ /home/cvsroot/gentoo-x86/skel.build,v 1.3 2001/07/05 02:43:36 drobbins Exp$

# This ebuild simply depends on lyx-base and lyx-utils.

DESCRIPTION="Lyx itself (lyx-base), plus all the utils/packages it can make use of (lyx-utils)."

HOMEPAGE="http://www.lyx.org/"

DEPEND="app-office/lyx-base
	app-office/lyx-utils"