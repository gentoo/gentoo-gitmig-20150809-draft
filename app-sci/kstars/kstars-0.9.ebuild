# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/kstars/kstars-0.9.ebuild,v 1.1 2002/08/11 22:11:04 danarmak Exp $
inherit kde-base 

need-kde 3

DESCRIPTION="A fun and educational desktop planetarium program for KDE; is in kdeedu for kde 3.1"
HOMEPAGE="http://kstars.sourceforge.net"
KEYWORDS="x86"

SRC_URI="mirror://sourceforge/${PN}/${P}.kde3.tar.gz"
LICENSE="GPL-2"

newdepend "!>=kde-base/kdeedu-3.1_alpha1"
