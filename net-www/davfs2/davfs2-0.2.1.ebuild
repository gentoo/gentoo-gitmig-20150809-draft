# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/davfs2/davfs2-0.2.1.ebuild,v 1.3 2003/10/10 17:24:36 mholzer Exp $

IUSE="ssl"

DESCRIPTION="a Linux file system driver that allows you to mount a WebDAV server as a local disk drive. Davfs2 uses Coda for kernel driver and neon for WebDAV interface. "
SRC_URI="mirror://sourceforge/dav/${P}.tar.gz"
HOMEPAGE="http://dav.sourceforge.net"
KEYWORDS="x86"

LICENSE="GPL-2"
DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )"
SLOT="0"

src_compile() {
	local myconf

	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall
}

pkg_postinst() {
	einfo "Remember you have to have coda compiled in to your kernel"
	einfo "In order to use Davfs2"
}
