# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kmod/kmod-7.ebuild,v 1.3 2012/03/19 22:51:42 williamh Exp $

EAPI=4

EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/kernel/${PN}/${PN}.git"

[[ ${PV} == 9999 ]] && vcs=git-2
inherit ${vcs} autotools eutils toolchain-funcs
unset vcs

if [[ ${PV} != 9999 ]] ; then
	SRC_URI="mirror://kernel/linux/utils/kernel/kmod/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~x86"
fi

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="http://git.kernel.org/?p=utils/kernel/kmod/kmod.git"

LICENSE="LGPL-2"
SLOT="0"
IUSE="debug doc lzma static-libs +tools zlib"

COMMON_DEPEND="!sys-apps/module-init-tools
	!sys-apps/modutils
	lzma? ( app-arch/xz-utils )
	zlib? ( sys-libs/zlib )"

DEPEND="${COMMON_DEPEND}
	doc? ( dev-util/gtk-doc )"
RDEPEND="${COMMON_DEPEND}"

src_prepare()
{
	if [ ! -e configure ]; then
		if use doc; then
			gtkdocize --copy --docdir libkmod/docs ||  die "gtkdocize failed"
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
	local myconf
	[[ ${PV} == 9999 ]] && myconf="$(use_enable doc gtk-doc)"

	econf \
		$(use_enable static-libs static) \
		$(use_enable tools) \
		$(use_enable debug) \
		$(use_with lzma xz) \
		$(use_with zlib) \
		${myconf}
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
