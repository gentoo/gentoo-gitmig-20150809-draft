# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/kportagemaster/kportagemaster-0.2.ebuild,v 1.3 2002/07/06 18:49:03 drobbins Exp $
inherit kde

need-kde 3

DESCRIPTION="A graphical frontend for emerge"
SRC_URI="http://user.cs.tu-berlin.de/~mehnert/${P}.tar.bz2"
HOMEPAGE="http://user.cs.tu-berlin.de/~mehnert/"
LICENSE="GPL-2"

newdepend "kde-base/kdebase" # needs kdesu
