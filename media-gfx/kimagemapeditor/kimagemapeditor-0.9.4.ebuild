# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimagemapeditor/kimagemapeditor-0.9.4.ebuild,v 1.5 2002/07/01 21:33:31 danarmak Exp $
inherit kde-base || die

LICENSE="GPL-2"
DESCRIPTION="An imagemap editor for KDE"
SRC_URI="mirror://sourceforge/kimagemapeditor/${P}.tar.gz"
HOMEPAGE="http://kimagemapeditor.sourceforge.net"

need-kde 2.2

