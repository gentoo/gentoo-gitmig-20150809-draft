# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/archive/archive-1.9.4.ebuild,v 1.3 2005/08/14 23:01:30 kugelfang Exp $


DESCRIPTION="Archive is a simple archiver for ROX Desktop"

HOMEPAGE="http://rox.sourceforge.net/"

SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

ROX_LIB_VER=1.9.6

APPNAME=Archive

inherit rox
