# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.6_beta2.ebuild,v 1.2 2003/10/31 21:12:57 usata Exp $

inherit kde
need-kde 3.1

MY_P="kile-1.6b2"
IUSE=""
DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="mirror://sourceforge/kile/${MY_P}.tar.gz"
HOMEPAGE="http://kile.sourceforge.net"
SLOT=0
DEPEND="$DEPEND dev-lang/perl"
RDEPEND="$RDEPEND virtual/tetex"

S=${WORKDIR}/${MY_P}
KEYWORDS="~x86"
LICENSE="GPL-2"
