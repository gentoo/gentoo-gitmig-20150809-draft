# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtella/qtella-0.3.3.ebuild,v 1.1 2001/12/17 12:38:06 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

S=${WORKDIR}/${P}
SRC_URI="http://prdownloads.sourceforge.net/qtella/${P}.tar.gz"

HOMEPAGE="http://www.qtella.net"
DESCRIPTION="QTella ${PV} (KDE Gnutella Client)"



