# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/kxicq2/kxicq2-0.7.6.ebuild,v 1.1 2002/01/08 01:00:21 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.1

SRC_URI="http://telia.dl.sourceforge.net/kxicq/${P}.tar.gz"

HOMEPAGE="http://www.kxicq.org"
DESCRIPTION="KDE 2.x ICQ Client, using the ICQ2000 protocol"


