# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimagemapeditor/kimagemapeditor-0.9.4.ebuild,v 1.2 2002/04/27 21:46:44 bangert Exp $


. /usr/portage/eclass/inherit.eclass
inherit kde-base || die

DESCRIPTION="An imagemap editor for KDE"
SRC_URI="http://prdownloads.sourceforge.net/kimagemapeditor/${P}.tar.gz"
HOMEPAGE="http://kimagemapeditor.sourceforge.net"

need-kde 2.2

