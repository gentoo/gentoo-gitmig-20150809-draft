# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lsscsi/lsscsi-0.15.ebuild,v 1.1 2005/11/29 02:48:59 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://www.torque.net/scsi/lsscsi.html"
SRC_URI="http://www.torque.net/scsi/lsscsi-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=sys-fs/sysfsutils-1.2.0"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS CREDITS ChangeLog NEWS README
}
