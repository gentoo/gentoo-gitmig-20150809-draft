# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/edit/edit-1.9.5.ebuild,v 1.3 2005/03/05 14:56:41 josejx Exp $

DESCRIPTION="Edit is a simple text editor for ROX Desktop"

HOMEPAGE="http://rox.sourceforge.net/"

SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE=""

ROX_LIB_VER=1.9.14

APPNAME=Edit

inherit rox
