# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/kgraphspace/kgraphspace-0.2.14-r2.ebuild,v 1.3 2002/05/21 18:14:06 danarmak Exp $

inherit kde-base || die

DESCRIPTION="A Disk space utility "
SRC_URI="http://download.sourceforge.net/kgraphspace/${P}.tar.bz2"
HOMEPAGE="http://kgraphspace.sourceforge.net"

need-kde 2.0
