# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.4.2.ebuild,v 1.2 2008/05/17 14:56:57 vanquirius Exp $

DESCRIPTION="Encrypted Filesystem module for Linux"
SRC_URI="http://encfs.googlecode.com/files/${P}.tgz"
HOMEPAGE="http://arg0.net/encfs"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"
SLOT="0"
IUSE="nls"

DEPEND=">=dev-libs/openssl-0.9.7
	>=sys-fs/fuse-2.6
	>=dev-libs/rlog-1.3.6
	>=dev-libs/boost-1.34
	nls? ( >=sys-devel/gettext-0.14.1 )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	einfo "Please see http://www.arg0.net/encfsintro"
	einfo "if this is your first time using encfs."
}
