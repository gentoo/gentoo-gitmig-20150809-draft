# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/mime-editor/mime-editor-0.1.3.ebuild,v 1.1 2004/11/27 10:09:30 sergey Exp $

DESCRIPTION="MIME-Editor is editor for the Shared MIME Database for ROX Desktop"

HOMEPAGE="http://rox.sourceforge.net/"

SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

ROX_LIB_VER=0.9.14

APPNAME=MIME-Editor

inherit rox
