# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/wakeonlan/wakeonlan-0.40.ebuild,v 1.3 2003/06/12 21:55:53 msterret Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Client for Wake-On-LAN"
SRC_URI="http://gsd.di.uminho.pt/jpo/software/wakeonlan/downloads/${P}.tar.gz"
HOMEPAGE="http://gsd.di.uminho.pt/jpo/software/wakeonlan/"
IUSE=""

SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="x86"
