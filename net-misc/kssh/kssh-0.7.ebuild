# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kssh/kssh-0.7.ebuild,v 1.11 2009/11/10 23:06:10 cla Exp $

ARTS_REQUIRED="never"
inherit kde

HOMEPAGE="http://kssh.sourceforge.net"
SRC_URI="mirror://sourceforge/kssh/${P}.tar.gz"
DESCRIPTION="KDE frontend for SSH"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 sparc ppc ~amd64"
IUSE=""

DEPEND=">=net-misc/openssh-3.1_p1"

need-kde 3

PATCHES="${FILESDIR}/${P}-noarts.patch"
