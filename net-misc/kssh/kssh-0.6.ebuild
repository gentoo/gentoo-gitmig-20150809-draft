# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kssh/kssh-0.6.ebuild,v 1.4 2002/07/08 18:16:04 phoenix Exp $

inherit kde-base || die

need-kde 3

S=${WORKDIR}/${P}
LICENSE="GPL-2"
SRC_URI="http://www.geocities.com/bilibao/${P}-rc.tar.gz"
HOMEPAGE="http://www.geocities.com/bilibao/kssh.html"
DESCRIPTION="KDE 3.x frontend for SSH"
KEYWORDS="x86"

newdepend ">=net-misc/openssh-3.1_p1"

