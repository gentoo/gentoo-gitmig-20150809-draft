# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.3.ebuild,v 1.2 2002/04/13 16:43:43 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3
DESCRIPTION="KDE MSN Messenger"
SRC_URI="http://www.kdedevelopers.net/kopete/files/${P}.tar.gz"
HOMEPAGE="http://www.kdedevelopers.net/kopete/"
