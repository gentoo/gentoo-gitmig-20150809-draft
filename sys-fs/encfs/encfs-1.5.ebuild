# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.5.ebuild,v 1.3 2008/11/16 17:31:10 maekke Exp $

inherit eutils

MY_P="${P}-2"

DESCRIPTION="Encrypted Filesystem module for Linux"
SRC_URI="http://encfs.googlecode.com/files/${MY_P}.tgz"
HOMEPAGE="http://arg0.net/encfs"
LICENSE="GPL-2"
KEYWORDS="amd64 ~sparc x86"
SLOT="0"
IUSE="nls"

DEPEND=">=dev-libs/openssl-0.9.7
	>=sys-fs/fuse-2.6
	>=dev-libs/rlog-1.3.6
	>=dev-libs/boost-1.34
	nls? ( >=sys-devel/gettext-0.14.1 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-boost-system-and-as-needed.patch
}

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
