# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/kxicq2/kxicq2-0.7.6.ebuild,v 1.2 2002/02/09 11:47:57 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.1

SRC_URI="http://telia.dl.sourceforge.net/kxicq/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.kxicq.org"
DESCRIPTION="KDE 2.x ICQ Client, using the ICQ2000 protocol"


