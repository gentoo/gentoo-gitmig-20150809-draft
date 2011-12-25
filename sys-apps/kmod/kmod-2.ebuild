# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kmod/kmod-2.ebuild,v 1.1 2011/12/25 21:21:40 mgorny Exp $

EAPI=4

inherit autotools-utils multilib toolchain-funcs

DESCRIPTION="Library and utilities for kernel module loading"
HOMEPAGE="http://git.profusion.mobi/cgit.cgi/kmod.git/" # XXX
SRC_URI="http://packages.profusion.mobi/kmod/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug static-libs +rootfs-install +tools zlib"

RDEPEND="zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

src_configure() {
	myeconfargs=(
		$(use rootfs-install && echo --exec-prefix=/)

		$(use_enable zlib)
		$(use_enable debug)
		$(use_enable tools)
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if use rootfs-install; then
		dodir /usr/$(get_libdir)
		# move pkg-config file and static libs to /usr
		if use static-libs; then
			mv "${D}"/$(get_libdir)/*.a "${D}"/usr/$(get_libdir)/ || die
			gen_usr_ldscript libkmod.so
			sed -i -e 's:/lib:/usr/lib:' \
				"${D}"/$(get_libdir)/pkgconfig/*.pc || die
		fi
		mv "${D}"/$(get_libdir)/pkgconfig "${D}"/usr/$(get_libdir)/ || die
	fi
}
