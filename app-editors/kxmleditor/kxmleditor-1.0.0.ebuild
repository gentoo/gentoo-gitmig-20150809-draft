# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kxmleditor/kxmleditor-1.0.0.ebuild,v 1.4 2004/03/13 23:00:56 mr_bones_ Exp $

inherit kde-base
need-kde 3

IUSE=""
SLOT="0"

DESCRIPTION="KDE XML Editor to display and edit contents of XML files"
HOMEPAGE="http://kxmleditor.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"
