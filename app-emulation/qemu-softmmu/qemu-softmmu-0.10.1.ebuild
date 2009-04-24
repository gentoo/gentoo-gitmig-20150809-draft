# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-softmmu/qemu-softmmu-0.10.1.ebuild,v 1.4 2009/04/24 10:59:50 lu_zero Exp $

inherit eutils flag-o-matic toolchain-funcs linux-info

EAPI=1

MY_PN=${PN/-softmmu/}
MY_P=${P/-softmmu/}

SRC_URI="http://savannah.nongnu.org/download/${MY_PN}/${MY_P}.tar.gz"

DESCRIPTION="Open source processor emulator"
HOMEPAGE="http://bellard.org/qemu/index.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"

IUSE="alsa esd gnutls ncurses pulseaudio +sdl vde kqemu kvm"
RESTRICT="test"

RDEPEND="sys-libs/zlib
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	esd? ( media-sound/esound )
	pulseaudio? ( media-sound/pulseaudio )
	gnutls? ( net-libs/gnutls )
	ncurses? ( sys-libs/ncurses )
	sdl? ( >=media-libs/libsdl-1.2.11 )
	vde? ( net-misc/vde )
	kqemu? ( >=app-emulation/kqemu-1.4.0_pre1 )"
#	fdt? ( sys-apps/dtc )

DEPEND="${RDEPEND}
	gnutls? ( dev-util/pkgconfig )
	app-text/texi2html"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# avoid fdt till an updated release appears
	sed -i -e 's:fdt="yes":fdt="no":' configure
	# prevent docs to get automatically installed
	sed -i '/$(DESTDIR)$(docdir)/d' Makefile
	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# avoid strip
	sed -i 's/$(INSTALL) -m 755 -s/$(INSTALL) -m 755/' \
		Makefile Makefile.target */Makefile
	epatch "${FILESDIR}/${P}-nopl-fix.patch"
}

src_compile() {
	local mycc conf_opts audio_opts

	audio_opts="oss"
	conf_opts="--disable-linux-user --disable-darwin-user --disable-bsd-user"
	use gnutls || conf_opts="$conf_opts --disable-vnc-tls"
	use ncurses || conf_opts="$conf_opts --disable-curses"
	use sdl || conf_opts="$conf_opts --disable-gfx-check --disable-sdl"
	use vde || conf_opts="$conf_opts --disable-vde"
	use kqemu || conf_opts="$conf_opts --disable-kqemu"
	use kvm || conf_opts="$conf_opts --disable-kvm"
#	use fdt || conf_opts="--disable-fdt"

	conf_opts="$conf_opts --prefix=/usr --disable-bluez"

	use alsa && audio_opts="alsa $audio_opts"
	use esd && audio_opts="esd $audio_opts"
	use pulseaudio && audio_opts="pa $audio_opts"
	use sdl && audio_opts="sdl $audio_opts"

	filter-flags -fpie -fstack-protector

	./configure ${conf_opts} \
		--audio-drv-list="$audio_opts" \
		--kerneldir="${KV_DIR}" \
		--cc=$(tc-getCC) --host-cc=$(tc-getCC) \
		|| die "econf failed"

	emake || die "emake qemu failed"

}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	insinto /etc/qemu
	insopts -m0755
	doins "${FILESDIR}/qemu-ifup"
	doins "${FILESDIR}/qemu-ifdown"

	dodoc pc-bios/README
	dodoc qemu-doc.html
	dodoc qemu-tech.html
}

pkg_postinst() {
	elog "You will need the Universal TUN/TAP driver compiled into your"
	elog "kernel or loaded as a module to use the virtual network device"
	elog "if using -net tap.  You will also need support for 802.1d"
	elog "Ethernet Bridging and a configured bridge if using the provided"
	elog "qemu-ifup script from /etc/qemu."
	echo
}
