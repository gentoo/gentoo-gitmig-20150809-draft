# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tcb/tcb-0.9.8.8.ebuild,v 1.2 2005/07/18 11:52:57 dholm Exp $

inherit eutils

DESCRIPTION="Libraries and tools implementing the tcb password shadowing scheme"
HOMEPAGE="http://www.openwall.com/"
SRC_URI="ftp://ftp.openwall.com/pub/projects/tcb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=sys-libs/pam-0.75"

pkg_setup() {
	# might want to add these into baselayout eventually...
	for group in auth chkpwd shadow ; do
		enewgroup ${group}
	done
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog
}

pkg_postinst() {
	einfo "You must now run /sbin/tcb_convert to convert your shadow to tcb"
	einfo "To remove this you must first run /sbin/tcp_unconvert and then unmerge"
}
