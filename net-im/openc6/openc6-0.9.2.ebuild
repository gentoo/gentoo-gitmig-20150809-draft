# Copyright 1999-2004 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/openc6/openc6-0.9.2.ebuild,v 1.2 2004/03/14 17:26:33 mr_bones_ Exp $

inherit kde

need-kde 3.1
need-qt 3.1

DESCRIPTION="OpenC6, a free C6 client."
HOMEPAGE="http://openc6.sourceforge.net/"
SRC_URI="mirror://sourceforge/openc6/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
