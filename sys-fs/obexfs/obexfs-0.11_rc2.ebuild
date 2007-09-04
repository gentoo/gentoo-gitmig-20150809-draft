# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/obexfs/obexfs-0.11_rc2.ebuild,v 1.1 2007/09/04 14:47:34 mrness Exp $

inherit linux-info

DESCRIPTION="FUSE filesystem interface for ObexFTP"
HOMEPAGE="http://dev.zuckschwerdt.org/openobex/wiki/ObexFs"
SRC_URI="http://triq.net/obexftp/${P/_/-}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-wireless/bluez-libs-2.25
	>=app-mobilephone/obexftp-0.22_rc6
	>=sys-fs/fuse-2.6.4"
RDEPEND=${DEPEND}

S="${WORKDIR}/${P%_*}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	# Check kernel configuration
	local CONFIG_CHECK="~FUSE_FS"
	check_extra_config
}
