# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kmod/kmod-5.ebuild,v 1.2 2012/02/08 16:56:21 mattst88 Exp $

EAPI=4

EGIT_REPO_URI="git://git.profusion.mobi/${PN}.git"

[[ "${PV}" == "9999" ]] && vcs=git-2
inherit ${vcs}  autotools eutils toolchain-funcs
unset vcs

if [[ "${PV}" != "9999" ]] ; then
	SRC_URI="http://packages.profusion.mobi/kmod/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~x86"
fi

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="http://git.profusion.mobi/cgit.cgi/kmod.git"

LICENSE="LGPL-2"
SLOT="0"
IUSE="+compat doc debug lzma static-libs +tools zlib"

REQUIRED_USE="compat? ( tools )"

COMMON_DEPEND="!sys-apps/module-init-tools
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
	econf \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_with lzma xz) \
		$(use_enable static-libs static) \
		$(use_enable tools) \
		$(use_with zlib)
}

src_install()
{
	default

	# we have a .pc file for people to use
	find "${D}" -name libkmod.la -delete

	if use compat && use tools; then
	dodir /bin
dosym /usr/bin/kmod /bin/lsmod
		dodir /sbin
		for cmd in depmod insmod modinfo modprobe rmmod; do
			dosym /usr/bin/kmod /sbin/$cmd
		done
	fi
}
