# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimagemapeditor/kimagemapeditor-0.9.4.ebuild,v 1.3 2002/05/21 18:14:10 danarmak Exp $



inherit kde-base || die

DESCRIPTION="An imagemap editor for KDE"
SRC_URI="http://prdownloads.sourceforge.net/kimagemapeditor/${P}.tar.gz"
HOMEPAGE="http://kimagemapeditor.sourceforge.net"

need-kde 2.2

