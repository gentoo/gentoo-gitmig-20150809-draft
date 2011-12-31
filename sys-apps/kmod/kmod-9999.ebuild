# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kmod/kmod-9999.ebuild,v 1.1 2011/12/31 08:08:46 vapier Exp $

EAPI="4"

inherit autotools-utils toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.profusion.mobi/kmod.git"
	inherit git-2 autotools
else
	SRC_URI="http://packages.profusion.mobi/kmod/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
fi

DESCRIPTION="Library and utilities for kernel module loading"
HOMEPAGE="http://git.profusion.mobi/cgit.cgi/kmod.git/" # XXX

LICENSE="LGPL-2"
SLOT="0"
IUSE="debug lzma static-libs +tools zlib"

RDEPEND="zlib? ( sys-libs/zlib )
	lzma? ( app-arch/xz-utils )"
DEPEND="${RDEPEND}"

src_prepare() {
	if [[ ! -e configure ]] ; then
		eautoreconf
		AT_NOELIBTOOLIZE=yes # autotools-utils calls this
	fi
	autotools-utils_src_prepare
}

src_configure() {
	myeconfargs=(
		$(use_enable debug)
		$(use_with lzma xz)
		$(use_enable tools)
		$(use_with zlib)
		--bindir=/bin
		--with-rootprefix=/
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	gen_usr_ldscript -a kmod
	dodir /sbin
	mv "${D}"/bin/kmod-{{ins,rm}mod,modprobe} "${D}"/sbin/ || die
}
