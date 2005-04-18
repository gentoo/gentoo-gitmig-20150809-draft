# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdstatus/cdstatus-0.95.03.ebuild,v 1.1 2005/04/18 20:37:36 luckyduck Exp $

inherit eutils

DESCRIPTION="Tool for diagnosing cdrom drive and digital data (audio) extraction"
HOMEPAGE="http://cdstatus.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdstatus/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc -amd64: 0.94a: Generates bad wav files  x86 is good...
KEYWORDS="~x86 -amd64 -sparc ~ppc64"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	dobin cdstatus
	fperms 755 /usr/bin/cdstatus
	dodoc AUTHORS README NEWS TODO
}
