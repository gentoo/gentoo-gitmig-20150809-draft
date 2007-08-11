# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-settings/nvidia-settings-1.0.20070302.ebuild,v 1.5 2007/08/11 03:58:00 beandog Exp $

inherit eutils toolchain-funcs multilib

MY_P="${PN}-1.0"

DESCRIPTION="NVIDIA Linux X11 Settings Utility"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86 ~x86-fbsd"
IUSE=""

# xorg-server is used in the depends as nvidia-settings builds against some
# headers in /usr/include/xorg/.
# This also allows us to optimize out a lot of the other dependancies, as
# between gtk and xorg-server, almost all libraries and headers are accounted
# for.
DEPEND=">=x11-libs/gtk+-2
	dev-util/pkgconfig
	x11-base/xorg-server
	x11-libs/libXt
	x11-libs/libXv
	x11-proto/xf86driproto
	x11-misc/imake
	x11-misc/gccmakedep"

RDEPEND=">=x11-libs/gtk+-2
	x11-base/xorg-server
	x11-libs/libXt
	x11-drivers/nvidia-drivers"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}/src/libXNVCtrl"
	einfo "Tweaking libXNVCtrl for build..."

	# This next voodoo is just to work around xmkmf's broken behaviour
	# after the Xorg move to /usr (or I think, as I have not messed
	# with it in ages).
	#ln -snf /usr/include/X11 include

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
	cd "${S}/src/libXNVCtrl"
	xmkmf -a || die "Running xmkmf failed!"
	make clean || die "Cleaning old libXNVCtrl failed"
	emake CDEBUGFLAGS="${CFLAGS}" CC="$(tc-getCC)" all || die "Building libXNVCtrl failed!"

	cd "${S}"
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
