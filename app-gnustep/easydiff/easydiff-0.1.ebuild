# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/easydiff/easydiff-0.1.ebuild,v 1.6 2004/07/22 21:40:41 fafhrd Exp $

inherit gnustep-old

need-gnustep-gui

DESCRIPTION="GNUstep app that lets you easily see the differences between two text files."
HOMEPAGE="http://www.collaboration-world.com/easydiff/"
LICENSE="GPL-2"
SRC_URI="http://freshmeat.net/redir/easydiff/33520/url_tgz/EasyDiff-${PV}.tar.gz"
KEYWORDS="x86 ~ppc"
SLOT="0"
S=${WORKDIR}/EasyDiff
IUSE=""
