# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wakeonlan/wakeonlan-0.40.ebuild,v 1.6 2004/06/25 00:19:38 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Client for Wake-On-LAN"
SRC_URI="http://gsd.di.uminho.pt/jpo/software/wakeonlan/downloads/${P}.tar.gz"
HOMEPAGE="http://gsd.di.uminho.pt/jpo/software/wakeonlan/"
IUSE=""

SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="x86 ~amd64"
