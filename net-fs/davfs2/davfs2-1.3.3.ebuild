# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/davfs2/davfs2-1.3.3.ebuild,v 1.1 2009/01/20 15:43:12 genstef Exp $

inherit linux-mod eutils

DESCRIPTION="a Linux file system driver that allows you to mount a WebDAV server as a local disk drive. Davfs2 uses fuse (or coda) for kernel driver and neon for WebDAV interface"
SRC_URI="mirror://sourceforge/dav/${P}.tar.gz"
HOMEPAGE="http://dav.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl debug socks5"
RESTRICT="test"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )
		socks5? ( >=net-proxy/dante-1.1.13 )
		dev-libs/libxml2
		net-misc/neon
		sys-libs/zlib"
SLOT="0"

src_compile() {
	local myconf

	if use debug; then
		myconf="--with-debug"
	fi

	econf \
		$(use_with ssl) \
		$(use_with socks5 socks) \
		--enable-largefile \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog FAQ INSTALL.davfs2 NEWS README \
		README.translators THANKS TODO

	# remove wrong locations created by install
	rm -r "${D}/usr/share/doc/davfs2"
	rm -r "${D}/usr/share/davfs2"

	dodir /var/run/mount.davfs
	keepdir /var/run/mount.davfs
	fowners root:users /var/run/mount.davfs
	fperms 1774 /var/run/mount.davfs

	# ignore nobody's home
	cat>>"${D}/etc/davfs2/davfs2.conf"<<EOF

# nobody is a system account in Gentoo
ignore_home nobody
EOF
}
