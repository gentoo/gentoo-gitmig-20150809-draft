# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kstars/kstars-0.9.ebuild,v 1.2 2002/10/04 05:00:33 vapier Exp $
inherit kde-base 

need-kde 3

DESCRIPTION="A fun and educational desktop planetarium program for KDE; is in kdeedu for kde 3.1"
HOMEPAGE="http://kstars.sourceforge.net"
KEYWORDS="x86"

SRC_URI="mirror://sourceforge/${PN}/${P}.kde3.tar.gz"
LICENSE="GPL-2"

newdepend "!>=kde-base/kdeedu-3.1_alpha1"
