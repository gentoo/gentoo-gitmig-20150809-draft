# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/davfs2/davfs2-0.2.2-r1.ebuild,v 1.1 2004/11/03 14:44:57 solar Exp $

inherit eutils

IUSE="ssl"

DESCRIPTION="a Linux file system driver that allows you to mount a WebDAV server as a local disk drive. Davfs2 uses Coda for kernel driver and neon for WebDAV interface"
SRC_URI="mirror://sourceforge/dav/${P}.tar.gz"
HOMEPAGE="http://dav.sourceforge.net"
KEYWORDS="~x86 ~ppc"

LICENSE="GPL-2"
DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/davfs2-0.2.2-pid.patch
}

src_compile() {
	econf `use_enable ssl` || die
	emake || die
}

src_install() {
	einstall
}

pkg_postinst() {
	einfo ""
	einfo "Remember you have to have coda compiled in to your kernel"
	einfo "in order to use davfs2"
	einfo ""
}
