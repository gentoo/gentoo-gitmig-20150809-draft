# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xpra/xpra-0.7.0.ebuild,v 1.2 2012/10/14 23:48:34 xmw Exp $

EAPI=3

PYTHON_DEPEND="*"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"
SUPPORT_PYTHON_ABIS="1"
inherit distutils eutils

DESCRIPTION="X Persistent Remote Apps (xpra) and Partitioning WM (parti) based on wimpiggy"
HOMEPAGE="http://xpra.org/"
SRC_URI="http://xpra.org/src/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+clipboard +rencode vpx webp x264"

COMMON_DEPEND="dev-python/pygobject:2
	dev-python/pygtk:2
	x11-drivers/xf86-input-void
	x11-drivers/xf86-video-dummy
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXtst
	vpx? ( media-libs/libvpx
		virtual/ffmpeg )
	webp? ( media-libs/libwebp )
	x264? ( media-libs/x264
		virtual/ffmpeg )"

RDEPEND="${COMMON_DEPEND}
	dev-python/dbus-python
	dev-python/imaging
	dev-python/ipython
	virtual/ssh
	x11-apps/setxkbmap
	x11-apps/xmodmap
	x11-base/xorg-server[-minimal]"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	>=dev-python/cython-0.16"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ignore-gentoo-no-compile.patch
	sed -e "s:libwebp.so.2:libwebp.so.4:" \
		-i "xpra/webm/__init__.py" || die

	use clipboard || epatch patches/disable-clipboard.patch
	use rencode   || epatch patches/disable-rencode.patch
	use vpx       || epatch patches/disable-vpx.patch
	use webp      || epatch patches/disable-webp.patch
	use x264      || epatch patches/disable-x264.patch

	distutils_src_prepare
}

src_install() {
	distutils_src_install
	rm -v "${D}"usr/share/parti/{parti.,}README \
		"${D}"usr/share/xpra/{webm/LICENSE,xpra.README} \
		"${D}"usr/share/wimpiggy/wimpiggy.README || die
	dodoc {parti.,wimpiggy.,xpra.,}README

	einfo
	elog "please make your Xorg binary readable for users of xpra"
	elog "  chmod a+r /usr/bin/Xorg"
	elog "and think about the security impact"
	einfo
}
