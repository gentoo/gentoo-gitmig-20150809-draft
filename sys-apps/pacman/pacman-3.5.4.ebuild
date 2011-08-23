# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pacman/pacman-3.5.4.ebuild,v 1.1 2011/08/23 04:05:45 binki Exp $

EAPI=4

inherit autotools autotools-utils

DESCRIPTION="Archlinux's binary package manager"
HOMEPAGE="http://archlinux.org/pacman/"
SRC_URI="ftp://ftp.archlinux.org/other/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc test"

COMMON_DEPEND="app-arch/libarchive
	dev-libs/openssl
	virtual/libiconv
	virtual/libintl
	sys-devel/gettext"
RDEPEND="${COMMON_DEPEND}
	app-arch/xz-utils"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-lang/python )"

RESTRICT="test"

src_prepare() {
	# Remove a line that adds -Werror in ./configure when --enable-debug
	# is passed:
	sed -i -e '/-Werror/d' configure.ac || die "-Werror"
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--localstatedir=/var
		--disable-git-version
		--without-fetch
		--with-openssl
		# Help protect users from shooting their Gentoo installation in
		# its foot.
		--with-root-dir="${EPREFIX}"/var/chroot/archlinux
		$(use_enable debug)
		$(use_enable doc)
		$(use_enable doc doxygen)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	dodir /etc/pacman.d
}

pkg_postinst() {
	einfo "Please see http://ohnopub.net/~ohnobinki/gentoo/arch/ for information"
	einfo "about setting up an archlinux chroot."
}
