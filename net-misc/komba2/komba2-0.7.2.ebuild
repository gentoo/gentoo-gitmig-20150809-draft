# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/komba2/komba2-0.7.2.ebuild,v 1.6 2002/07/11 06:30:48 drobbins Exp $

inherit kde-base || die

need-kde 2.2

DESCRIPTION="Windows(Samba) network administrating tool for KDE"
HOMEPAGE="http://zeus.fh-brandenburg.de/~schwanz/php/komba.php3"
KEYWORDS="x86"
LICENSE="GPL-2"
newdepend "$DEPEND >=net-fs/samba-2.2"

SRC_URI="http://zeus.fh-brandenburg.de/~schwanz/files/${P}.tar.gz"
