# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lsscsi/lsscsi-0.21.ebuild,v 1.1 2008/11/18 02:12:18 robbat2 Exp $

inherit toolchain-funcs

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://sg.danny.cz/scsi/lsscsi.html"
SRC_URI="http://sg.danny.cz/scsi/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-fs/sysfsutils-1.2.0"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS CREDITS ChangeLog NEWS README
}
