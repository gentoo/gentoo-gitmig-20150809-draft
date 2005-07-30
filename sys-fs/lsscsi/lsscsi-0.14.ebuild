# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lsscsi/lsscsi-0.14.ebuild,v 1.3 2005/07/30 02:39:48 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://www.torque.net/scsi/lsscsi.html"
SRC_URI="http://www.torque.net/scsi/lsscsi-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ppc x86"
IUSE=""

DEPEND=">=sys-fs/sysfsutils-1.2.0"

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		|| die "emake failed"
}

src_install() {
	dobin lsscsi || die "dobin failed"
	doman lsscsi.8
	dodoc CHANGELOG README
}
