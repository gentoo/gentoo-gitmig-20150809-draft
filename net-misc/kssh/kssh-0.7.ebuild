# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kssh/kssh-0.7.ebuild,v 1.2 2004/03/14 17:30:09 mr_bones_ Exp $

inherit kde

need-kde 3

S=${WORKDIR}/${P}
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge//kssh/${P}.tar.gz"
HOMEPAGE="http://kssh.sourceforge.net"
DESCRIPTION="KDE 3.x frontend for SSH"
KEYWORDS="~x86 ~sparc ~ppc"

newdepend ">=net-misc/openssh-3.1_p1"

