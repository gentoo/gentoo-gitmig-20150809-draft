# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/knowit/knowit-0.10.ebuild,v 1.12 2008/06/29 16:07:31 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KnowIt is a simple tool for managing notes - similar to TuxCards but KDE based."
SRC_URI="http://knowit.sourceforge.net/files/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"
HOMEPAGE="http://knowit.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""
SLOT="0"

need-kde 3.5

PATCHES=( "${FILESDIR}/knowit-0.10-desktop-file-entry.diff" )
