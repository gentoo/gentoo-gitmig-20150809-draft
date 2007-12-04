# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/mime-editor/mime-editor-0.5-r2.ebuild,v 1.1 2007/12/04 21:37:44 lack Exp $

ROX_LIB_VER="2.0.4-r1"
inherit rox-0install

DESCRIPTION="MIME-Editor is editor for the Shared MIME Database for ROX Desktop"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

APPNAME=MIME-Editor
APPCATEGORY="System;Core"
