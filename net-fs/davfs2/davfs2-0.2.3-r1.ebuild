# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/davfs2/davfs2-0.2.3-r1.ebuild,v 1.2 2005/01/26 15:32:36 genstef Exp $

inherit linux-info eutils

IUSE="ssl debug"

DESCRIPTION="a Linux file system driver that allows you to mount a WebDAV server as a local disk drive. Davfs2 uses Coda for kernel driver and neon for WebDAV interface"
SRC_URI="mirror://sourceforge/dav/${P}.tar.gz"
HOMEPAGE="http://dav.sourceforge.net"
KEYWORDS="x86 ~ppc"

LICENSE="GPL-2"
DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )
		dev-libs/libxml2
		sys-libs/zlib"
SLOT="0"

CONFIG_CHECK="CODA_FS"
CODA_FS_ERROR="Coda can be found in filesystems, network filesystems"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}.nokernelsrc.patch
}

src_compile() {
	local myconf

	if useq debug; then
		myconf="--with-debug"
	fi

	econf $(use_with ssl) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	dodoc BUGS ChangeLog FAQ README THANKS TODO

	dodir /etc/modules.d
	cat >${D}/etc/modules.d/davfs2 <<EOF
alias char-major-67	coda
alias /dev/davfs*	coda
EOF
}

pkg_postinst() {
	update-modules
}
