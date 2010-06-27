# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.6.ebuild,v 1.1 2010/06/27 20:54:55 ssuominen Exp $

EAPI=2

DESCRIPTION="An implementation of encrypted filesystem in user-space using FUSE"
HOMEPAGE="http://www.arg0.net/encfs/"
SRC_URI="http://encfs.googlecode.com/files/${P}-1.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="nls"

RDEPEND=">=dev-libs/boost-1.34
	>=dev-libs/openssl-0.9.7
	>=dev-libs/rlog-1.4
	>=sys-fs/fuse-2.7.0"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/pkgconfig
	sys-apps/attr
	nls? ( sys-devel/gettext )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
	find "${D}" -name '*.la' -delete
}
