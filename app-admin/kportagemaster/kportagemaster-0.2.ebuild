# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/kportagemaster/kportagemaster-0.2.ebuild,v 1.6 2002/07/25 12:57:05 seemant Exp $
inherit kde

need-kde 3

DESCRIPTION="A graphical frontend for emerge"
SRC_URI="http://user.cs.tu-berlin.de/~mehnert/${P}.tar.bz2"
HOMEPAGE="http://user.cs.tu-berlin.de/~mehnert/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

newdepend "kde-base/kdebase" # needs kdesu
