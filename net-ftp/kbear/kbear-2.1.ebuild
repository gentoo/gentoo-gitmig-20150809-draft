# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-2.1.ebuild,v 1.5 2003/06/18 13:16:04 vapier Exp $

inherit kde-base 

DESCRIPTION="A KDE 3.x FTP Manager"
SRC_URI="mirror://sourceforge/kbear/${P}-1.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"

need-kde 3
