# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-settings/nvidia-settings-1.0.20051122-r3.ebuild,v 1.2 2006/04/17 10:42:11 flameeyes Exp $

inherit eutils toolchain-funcs multilib

NVIDIA_VERSION="1.0.7664"
S="${WORKDIR}/${PN}-1.0"
DESCRIPTION="NVIDIA Linux X11 Settings Utility"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz
		http://dev.gentoo.org/~azarah/nvidia/${P}.tar.gz"
# Real SRC_URI:  ftp://download.nvidia.com/XFree86/nvidia-settings/

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=

# xorg-server is used in the depends as nvidia-settings builds against some
# headers in /usr/include/xorg/.
# This also allows us to optimize out a lot of the other dependancies, as
# between gtk and xorg-server, almost all libraries and headers are accounted
# for.
DEPEND="virtual/libc
		>=x11-libs/gtk+-2
		|| ( ( 	x11-base/xorg-server
				x11-libs/libXt
				x11-proto/xf86driproto
				x11-misc/imake
				x11-misc/gccmakedep )
			virtual/x11
		)"
RDEPEND=">=media-video/nvidia-glx-${NVIDIA_VERSION}
		|| ( >=media-video/nvidia-kernel-${NVIDIA_VERSION}
			>=media-video/nvidia-freebsd-${NVIDIA_VERSION} )
		>=x11-libs/gtk+-2
		|| ( (	x11-base/xorg-server
				x11-libs/libXt )
			virtual/x11
		)"

src_unpack() {
	unpack ${A}
	cd ${S}/src/libXNVCtrl
	einfo "Tweaking libXNVCtrl for build..."
	# This next voodoo is just to work around xmkmf's broken behaviour
	# after the Xorg move to /usr (or I think, as I have not messed
	# with it in ages).
	ln -snf ${ROOT}/usr/include/X11 include

	# Ensure that libNVCtrl.a is actually built
	# Regardless of how NormalLibXrandr was built
	# (NormalLibXrandr indicates if Xrandr was built as static or not)
	# NormalLibXrandr was 'YES' in Xorg-6.8, but is 'NO' in 7.0.
	sed -i.orig \
		-e 's,DoNormalLib NormalLibXrandr,DoNormalLib YES,g' \
		Imakefile

	# for a rainy day, when we need a shared libXNVCtrl.so
	#-e 'a#define DoSharedLib YES\n' \
}

src_compile() {
	einfo "Building libXNVCtrl..."
	cd ${S}/src/libXNVCtrl
	xmkmf -a || die "Running xmkmf failed!"
	make clean || die "Cleaning old libXNVCtrl failed"
	emake CDEBUGFLAGS="${CFLAGS}" CC="$(tc-getCC)" all || die "Building libXNVCtrl failed!"

	cd ${S}
	einfo "Building nVidia-Settings..."
	emake  CC="$(tc-getCC)" || die "Failed to build nvidia-settings"
}

src_install() {
	# Install the executable
	exeinto /usr/bin
	doexe nvidia-settings

	# Install libXNVCtrl and headers
	insinto "/usr/$(get_libdir)"
	doins src/libXNVCtrl/libXNVCtrl.a
	insinto /usr/include/NVCtrl
	doins src/libXNVCtrl/{NVCtrl,NVCtrlLib}.h

	# Install icon and .desktop entry
	doicon "${FILESDIR}/icon/${PN}.png"
	domenu "${FILESDIR}/icon/${PN}.desktop"

	# Install manpage
	doman doc/nvidia-settings.1

	# Now install documentation
	dodoc doc/*.txt
}
