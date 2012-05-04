# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.7.4.ebuild,v 1.5 2012/05/04 19:09:17 jdhore Exp $

EAPI=2
inherit eutils multilib versionator

DESCRIPTION="An implementation of encrypted filesystem in user-space using FUSE"
HOMEPAGE="http://www.arg0.net/encfs/"
SRC_URI="http://encfs.googlecode.com/files/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE="xattr"

RDEPEND=">=dev-libs/boost-1.34
	>=dev-libs/openssl-0.9.7
	>=dev-libs/rlog-1.4
	>=sys-fs/fuse-2.7.0
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-lang/perl
	virtual/pkgconfig
	xattr? ( sys-apps/attr )
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.7.4-r68:69.patch
}

src_configure() {
	BOOST_PKG="$(best_version dev-libs/boost)"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	BOOST_INC="/usr/include/boost-${BOOST_VER}"
	BOOST_LIB="/usr/$(get_libdir)/boost-${BOOST_VER}"
	einfo "Building against ${BOOST_PKG}."

	use xattr || export ac_cv_header_attr_xattr_h=no

	econf \
		--with-boost=${BOOST_INC} \
		--with-boost-libdir=${BOOST_LIB} \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
	find "${D}" -name '*.la' -delete
}
