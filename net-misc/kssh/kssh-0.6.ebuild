# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kssh/kssh-0.6.ebuild,v 1.1 2002/04/15 22:37:30 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3

S=${WORKDIR}/${P}
SRC_URI="http://www.geocities.com/bilibao/${P}-rc.tar.gz"
HOMEPAGE="http://www.geocities.com/bilibao/kssh.html"
DESCRIPTION="KDE 3.x frontend for SSH"

newdepend ">=net-misc/openssh-3.1_p1"

