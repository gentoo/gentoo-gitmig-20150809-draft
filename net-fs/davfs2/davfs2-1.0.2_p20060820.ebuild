# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/davfs2/davfs2-1.0.2_p20060820.ebuild,v 1.1 2006/08/22 14:43:30 genstef Exp $

inherit linux-mod eutils

DESCRIPTION="a Linux file system driver that allows you to mount a WebDAV server as a local disk drive. Davfs2 uses Coda for kernel driver and neon for WebDAV interface"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.bz2"
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
S=${WORKDIR}/${PN}

CONFIG_CHECK="CODA_FS !CODA_FS_OLD_API"
CODA_FS_ERROR="${P} requires kernel support for Coda to be found in filesystems, network filesystems"

src_compile() {
	./autogen.sh
	local myconf

	if use debug; then
		myconf="--with-debug"
	fi
	if kernel_is 2 4; then
		myconf="${myconf} --with-kernel-src=${KV_DIR}"
	else
		myconf="${myconf} --without-kernel-src"
	fi

	econf \
		$(use_with ssl) \
		$(use_with socks5 socks) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	cd doc
	dodoc BUGS ChangeLog davfs2.conf.template FAQ NEWS README secrets.template THANKS TODO BUGS

	#fix einstalled files in wrong places
	cd ${D}/usr/share/davfs2
	rm COPYING ChangeLog davfs2.conf.template FAQ NEWS README secrets.template THANKS TODO BUGS GPL
	rmdir ${D}/usr/share/davfs2

	dodir /var/run/mount.davfs
	keepdir /var/run/mount.davfs
	fowners root:users /var/run/mount.davfs
	fperms 1774 /var/run/mount.davfs

	dodir /etc/modules.d
	cat >${D}/etc/modules.d/davfs2 <<EOF
alias char-major-67	coda
alias /dev/davfs*	coda
EOF
}
