# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/komba2/komba2-0.7.2.ebuild,v 1.11 2003/02/13 14:57:20 vapier Exp $

inherit kde-base || die

need-kde 2.2

DESCRIPTION="Windows(Samba) network administrating tool for KDE"
HOMEPAGE="http://zeus.fh-brandenburg.de/~schwanz/php/komba.php3"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
newdepend "$DEPEND >=net-fs/samba-2.2"

SRC_URI="http://zeus.fh-brandenburg.de/~schwanz/files/${P}.tar.gz"
