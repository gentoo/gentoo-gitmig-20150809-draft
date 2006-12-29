# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/fusesmb/fusesmb-0.8.5.ebuild,v 1.1 2006/12/29 21:57:21 genstef Exp $

inherit eutils

DESCRIPTION="Instead of mounting one Samba share at a time, you mount all workgroups, hosts and shares at once."
HOMEPAGE="http://www.ricardis.tudelft.nl/~vincent/fusesmb/"
SRC_URI="http://www.ricardis.tudelft.nl/~vincent/fusesmb/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-fs/fuse-2.3
		>=net-fs/samba-3.0"

DEPEND="${RDEPEND}
	virtual/libc
	sys-devel/libtool
	sys-devel/make"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:\(FUSE_USE_VERSION.\)23:\122:" config* || die "sed failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog README fusesmb.conf.ex
}

pkg_postinst() {
	einfo ""
	einfo "For quick usage, exec:"
	einfo "'modprobe fuse'"
	einfo "'fusesmb -oallow_other /mnt/samba'"
	einfo ""
}
