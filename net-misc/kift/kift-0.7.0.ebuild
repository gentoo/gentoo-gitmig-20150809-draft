# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kift/kift-0.7.0.ebuild,v 1.4 2002/05/21 18:14:11 danarmak Exp $

inherit kde-base || die

need-kde 2.1

DESCRIPTION="KDE interface for giFT"
HOMEPAGE="http://kift.sourceforge.net"

newdepend "$DEPEND >=net-misc/gift-0.9.7"

SRC_URI="http://prdownloads.sourceforge.net/kift/${P}.tar.gz"
