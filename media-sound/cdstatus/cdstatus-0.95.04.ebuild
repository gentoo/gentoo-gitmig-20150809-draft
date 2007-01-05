# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdstatus/cdstatus-0.95.04.ebuild,v 1.5 2007/01/05 17:26:14 flameeyes Exp $

inherit eutils

DESCRIPTION="Tool for diagnosing cdrom drive and digital data (audio) extraction"
HOMEPAGE="http://cdstatus.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdstatus/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc -amd64: 0.94a: Generates bad wav files  x86 is good...
KEYWORDS="-amd64 ~ppc ~ppc64 -sparc ~x86"
IUSE=""

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	elog
	elog "Copy cdstatus.cfg from /usr/share/cdstatus.cfg"
	elog "to your home directory and edit as needed."
	elog
}
