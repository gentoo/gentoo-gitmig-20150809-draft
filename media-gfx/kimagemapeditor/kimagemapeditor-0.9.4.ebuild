# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimagemapeditor/kimagemapeditor-0.9.4.ebuild,v 1.7 2002/07/23 05:18:07 seemant Exp $
inherit kde-base || die

DESCRIPTION="An imagemap editor for KDE"
SRC_URI="mirror://sourceforge/kimagemapeditor/${P}.tar.gz"
HOMEPAGE="http://kimagemapeditor.sourceforge.net"

need-kde 2.2

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
