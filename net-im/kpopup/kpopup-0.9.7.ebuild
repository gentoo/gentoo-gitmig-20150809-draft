# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kpopup/kpopup-0.9.7.ebuild,v 1.3 2004/07/31 15:25:19 centic Exp $

inherit kde

DESCRIPTION="An SMB Network Messenger"
HOMEPAGE="http://www.henschelsoft.de/kpopup.html"
SRC_URI="http://www.henschelsoft.de/kpopup/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=net-fs/samba-2.2"
need-kde 3

src_install() {
	make DESTDIR=${D} install || die "make install failed"
#	make DESTDIR=${D} create_kpopup_data_dir || die "create data dir failed"
	diropts -m0777
	dodir /var/lib/kpopup
	diropts -m0755
}

pkg_postinst() {
	einfo ""
	einfo "Locate the [global] section of your Samba configuration file (smb.conf) and"
	einfo "add the following line:"
	einfo ""
	einfo "message command = sh -c '/usr/bin/receivepopup.sh \"%s\" \"%f\"'"
	einfo ""
}
