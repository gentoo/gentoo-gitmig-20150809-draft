# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/knoda/knoda-0.6_pre3.ebuild,v 1.1 2003/04/24 12:30:25 pauldv Exp $

inherit kde-base 
need-kde 3 

NEWP=${P/_pre/-pre}
S=${WORKDIR}/${NEWP}

IUSE=""
DESCRIPTION="KDE database frontend based on the hk_classes library"
SRC_URI="http://hk-classes.sourceforge.net/${NEWP}.tar.gz"
HOMEPAGE="http://hk-classes.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86"

newdepend "=dev-db/hk_classes-0.6*"
