# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kssh/kssh-0.7.ebuild,v 1.10 2007/02/04 08:27:57 mr_bones_ Exp $

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
