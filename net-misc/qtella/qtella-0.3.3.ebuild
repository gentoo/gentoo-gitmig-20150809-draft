# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtella/qtella-0.3.3.ebuild,v 1.2 2001/12/23 21:35:16 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.2

SRC_URI="http://prdownloads.sourceforge.net/qtella/${P}.tar.gz"

HOMEPAGE="http://www.qtella.net"
DESCRIPTION="QTella ${PV} (KDE Gnutella Client)"



