# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/kgraphspace/kgraphspace-0.2.14-r2.ebuild,v 1.1 2001/12/29 17:41:37 danarmak Exp $
. /usr/portage/eclass/inherit.eclass
inherit kde-base || die

DESCRIPTION="A Disk space utility "
SRC_URI="http://download.sourceforge.net/kgraphspace/${P}.tar.bz2"
HOMEPAGE="http://kgraphspace.sourceforge.net"

need-kde 2.0
