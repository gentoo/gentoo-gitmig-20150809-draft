# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/archive/archive-2.0.ebuild,v 1.2 2005/11/19 18:44:57 svyatogor Exp $

DESCRIPTION="Archive is a simple archiver for ROX Desktop"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
ROX_LIB_VER=2.0.0

APPNAME=Archive

inherit rox
