# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-2.1.ebuild,v 1.8 2004/05/16 21:15:57 centic Exp $

inherit kde

DESCRIPTION="A KDE 3.x FTP Manager"
SRC_URI="mirror://sourceforge/kbear/${P}-1.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net/"

SLOT="0"
IUSE=""

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"

need-kde 3
