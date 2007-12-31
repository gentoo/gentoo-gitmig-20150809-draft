# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/carl/carl-0.7.ebuild,v 1.5 2007/12/31 14:20:29 armin76 Exp $

inherit distutils

DESCRIPTION="An rsync logfile analyzer"
HOMEPAGE="http://www.schwarzvogel.de/software-misc.shtml"
SRC_URI="http://www.schwarzvogel.de/pkgs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="virtual/python"
DOCS="README"
