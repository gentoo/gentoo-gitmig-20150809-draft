# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/talksoup/talksoup-0.81.ebuild,v 1.1 2003/07/17 17:26:10 brain Exp $

inherit gnustep

need-gnustep-gui

DESCRIPTION="GNUstep based IRC Client"
HOMEPAGE="http://linuks.mine.nu/andy/talksoup/index.html"
LICENSE="GPL-2"
SRC_URI="http://linuks.mine.nu/andy/files/talksoup/TalkSoup-${PV}.tar.gz"
KEYWORDS="x86"
SLOT="0"
S=${WORKDIR}/TalkSoup-${PV}
