# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/00baselayout/00baselayout-1.1-r1.ebuild,v 1.3 2000/08/25 02:24:58 drobbins Exp $# Copyright 1999-2000 Gentoo Technologies, Inc.

P=00baselayout-1.1
A=""
S=${WORKDIR}/${P}
DESCRIPTION="Baselayout"
SRC_URI=""

src_install()
{
  cp -a ${FILESDIR}/${P}/* ${D}
}





