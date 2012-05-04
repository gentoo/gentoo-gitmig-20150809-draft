# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kmod/kmod-9999.ebuild,v 1.26 2012/05/04 09:17:27 jdhore Exp $

EAPI=4

EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/kernel/${PN}/${PN}.git"

[[ ${PV} == 9999 ]] && vcs=git-2
inherit ${vcs} autotools eutils toolchain-funcs
unset vcs

if [[ ${PV} != 9999 ]] ; then
	SRC_URI="mirror://kernel/linux/utils/kernel/kmod/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
fi

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="http://git.kernel.org/?p=utils/kernel/kmod/kmod.git"

LICENSE="LGPL-2"
SLOT="0"
IUSE="debug doc lzma static-libs +tools zlib"

RDEPEND="!sys-apps/module-init-tools
	!sys-apps/modutils
	lzma? ( app-arch/xz-utils )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	lzma? ( virtual/pkgconfig )
	zlib? ( virtual/pkgconfig )"

# Upstream does not support running the test suite with custom configure flags.
# I was also told that the test suite is intended for kmod developers.
# So we have to restrict it.
# See bug #408915.
RESTRICT="test"

src_prepare()
{
	if [ ! -e configure ]; then
		if use doc; then
			gtkdocize --copy --docdir libkmod/docs || die
		else
			touch libkmod/docs/gtk-doc.make
		fi
		eautoreconf
	else
		elibtoolize
	fi
}

src_configure()
{
	# http://bugs.gentoo.org/410865
	if has_version '<sys-libs/zlib-1.2.6'; then
		export zlib_CFLAGS="-I/usr/include"
		export zlib_LIBS="-lz"
	fi

	econf \
		$(use_enable static-libs static) \
		$(use_enable tools) \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_with lzma xz) \
		$(use_with zlib)
}

src_install()
{
	default

	find "${D}" -name libkmod.la -exec rm -f {} +

	if use tools; then
		dodir /bin
		dosym /usr/bin/kmod /bin/lsmod
		dodir /sbin
		local cmd
		for cmd in depmod insmod modinfo modprobe rmmod; do
			dosym /usr/bin/kmod /sbin/${cmd}
		done
	fi
}
