# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/unace/unace-2.0.4.ebuild,v 1.2 2002/07/11 06:30:10 drobbins Exp $

S=${WORKDIR}
DESCRIPTION="ACE unarchiver"
SRC_URI="http://www.vikingassociates.com/winace/linunace204.tgz"
HOMEPAGE="http://www.winace.com/"
LICENSE="Proprietary"
DEPEND="virtual/glibc"

src_install () {
	into /opt/ace
	dobin unace
}
