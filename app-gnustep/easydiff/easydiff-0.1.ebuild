# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/easydiff/easydiff-0.1.ebuild,v 1.2 2003/07/16 16:29:30 brain Exp $

inherit gnustep

need-gnustep-gui

DESCRIPTION="GNUstep app that lets you easily see the differences between two text files."
HOMEPAGE="http://www.collaboration-world.com/easydiff/"
LICENSE="GPL-2"
SRC_URI="http://freshmeat.net/redir/easydiff/33520/url_tgz/EasyDiff-${PV}.tar.gz"
KEYWORDS="x86"
SLOT="0"
S=${WORKDIR}/EasyDiff
