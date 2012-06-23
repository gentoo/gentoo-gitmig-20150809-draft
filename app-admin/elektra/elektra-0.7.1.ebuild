# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/elektra/elektra-0.7.1.ebuild,v 1.6 2012/06/23 07:47:24 ssuominen Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="universal and secure framework to store config parameters in a hierarchical key-value pair mechanism"
HOMEPAGE="http://sourceforge.net/projects/elektra/"
SRC_URI="ftp://ftp.markus-raab.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="iconv static-libs test"

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	sys-devel/libtool
	iconv? ( virtual/libiconv )
	test? ( dev-libs/libxml2[static-libs] )"

src_prepare() {
	einfo 'Removing bundled libltdl'
	rm -rf libltdl || die

	epatch \
		"${FILESDIR}"/${P}-test.patch \
		"${FILESDIR}"/${P}-ltdl.patch \
		"${FILESDIR}"/${P}-automake-1.12.patch

	touch config.rpath
	eautoreconf
}

src_configure() {
	# berkeleydb, daemon, fstab, gconf, python do not work
	econf \
		--enable-filesys \
		--enable-hosts \
		--enable-ini \
		--enable-passwd \
		--disable-berkeleydb \
		--disable-fstab \
		--disable-gconf \
		--disable-daemon \
		--enable-cpp \
		--disable-python \
		--enable-gcov \
		$(use_enable iconv) \
		$(use_enable static-libs static) \
		--with-docdir=/usr/share/doc/${PF} \
		--with-develdocdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install

	if ! use static-libs; then
		find "${D}" -name "*.a" -delete || die
	fi

	dodoc AUTHORS ChangeLog NEWS README TODO
}
