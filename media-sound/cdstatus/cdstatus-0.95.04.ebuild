# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdstatus/cdstatus-0.95.04.ebuild,v 1.7 2009/06/11 13:45:20 fauli Exp $

EAPI=2
inherit eutils

DESCRIPTION="Tool for diagnosing cdrom drive and digital data (audio) extraction"
HOMEPAGE="http://cdstatus.sourceforge.net"
SRC_URI="mirror://sourceforge/cdstatus/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	elog "Copy cdstatus.cfg from /usr/share/cdstatus.cfg"
	elog "to your home directory and edit as needed."
}
