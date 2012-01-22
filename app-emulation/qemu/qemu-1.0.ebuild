# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu/qemu-1.0.ebuild,v 1.2 2012/01/22 17:55:03 slyfox Exp $

EAPI="2"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://git.qemu.org/qemu.git
		http://git.qemu.org/git/qemu.git"
	GIT_ECLASS="git-2"
fi

inherit eutils flag-o-matic ${GIT_ECLASS} linux-info toolchain-funcs

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://wiki.qemu.org/download/${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
fi

DESCRIPTION="QEMU emulator and ABI wrapper"
HOMEPAGE="http://www.qemu.org"

LICENSE="GPL-2"
SLOT="0"
IUSE="+aio alsa bluetooth brltty curl esd fdt hardened jpeg ncurses nss \
png pulseaudio qemu-ifup rbd sasl sdl spice ssl static threads vde \
+vhost-net xattr xen"

COMMON_TARGETS="i386 x86_64 alpha arm cris m68k microblaze microblazeel mips mipsel ppc ppc64 sh4 sh4eb sparc sparc64 s390x"
IUSE_SOFTMMU_TARGETS="${COMMON_TARGETS} lm32 mips64 mips64el ppcemb xtensa xtensaeb"
IUSE_USER_TARGETS="${COMMON_TARGETS} armeb ppc64abi32 sparc32plus unicore32"

for target in ${IUSE_SOFTMMU_TARGETS}; do
	IUSE="${IUSE} +qemu_softmmu_targets_${target}"
done

for target in ${IUSE_USER_TARGETS}; do
	IUSE="${IUSE} +qemu_user_targets_${target}"
done

RESTRICT="test"

RDEPEND="
	!app-emulation/qemu-kvm
	!app-emulation/qemu-user
	>=dev-libs/glib-2.0
	sys-apps/pciutils
	>=sys-apps/util-linux-2.16.0
	sys-libs/zlib
	aio? ( dev-libs/libaio )
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	bluetooth? ( net-wireless/bluez )
	brltty? ( app-accessibility/brltty )
	curl? ( net-misc/curl )
	esd? ( media-sound/esound )
	fdt? ( >=sys-apps/dtc-1.2.0 )
	jpeg? ( virtual/jpeg )
	ncurses? ( sys-libs/ncurses )
	nss? ( dev-libs/nss )
	png? ( media-libs/libpng )
	pulseaudio? ( media-sound/pulseaudio )
	qemu-ifup? ( sys-apps/iproute2 net-misc/bridge-utils )
	rbd? ( sys-cluster/ceph )
	sasl? ( dev-libs/cyrus-sasl )
	sdl? ( >=media-libs/libsdl-1.2.11[X] )
	spice? ( >=app-emulation/spice-0.9.0
			>=app-emulation/spice-protocol-0.8.1 )
	ssl? ( net-libs/gnutls )
	vde? ( net-misc/vde )
	xattr? ( sys-apps/attr )
	xen? ( app-emulation/xen-tools )

	qemu_softmmu_targets_lm32? (
		x11-libs/libX11
		virtual/opengl
	)
"

DEPEND="${RDEPEND}
	app-text/texi2html
	dev-util/pkgconfig
	>=sys-kernel/linux-headers-2.6.35
"

# alpha ELF binary. don't let portage mess with it
STRIP_MASK="usr/share/qemu/palcode-clipper"

QA_PRESTRIPPED="
	usr/share/qemu/openbios-ppc
	usr/share/qemu/openbios-sparc64
	usr/share/qemu/openbios-sparc32
	usr/share/qemu/palcode-clipper
"
# keep sorted
QA_WX_LOAD="${QA_PRESTRIPPED}
	usr/bin/qemu-alpha
	usr/bin/qemu-arm
	usr/bin/qemu-armeb
	usr/bin/qemu-cris
	usr/bin/qemu-i386
	usr/bin/qemu-m68k
	usr/bin/qemu-microblaze
	usr/bin/qemu-microblazeel
	usr/bin/qemu-mips
	usr/bin/qemu-mipsel
	usr/bin/qemu-sh4
	usr/bin/qemu-sh4eb
	usr/bin/qemu-sparc
	usr/bin/qemu-sparc32plus
	usr/bin/qemu-sparc64
	usr/bin/qemu-s390x
	usr/bin/qemu-unicore32
	usr/bin/qemu-x86_64
"

pkg_setup() {
	use qemu_softmmu_targets_x86_64 || ewarn "You disabled default target QEMU_SOFTMMU_TARGETS=x86_64"
}

src_prepare() {
	# prevent docs to get automatically installed
	sed -i '/$(DESTDIR)$(docdir)/d' Makefile || die
	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target || die
	# append CFLAGS while linking
	sed -i 's/$(LDFLAGS)/$(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS)/' rules.mak || die

	# Fix underlinking.
	# Fault reproducer: USE=nss QEMU_SOFTMMU_TARGETS=lm32 QEMU_USER_TARGETS=
	sed -i 's/opengl_libs="-lGL"/opengl_libs="-lGL -lX11"/' configure || die
}

src_configure() {
	local conf_opts audio_opts user_targets

	for target in ${IUSE_SOFTMMU_TARGETS} ; do
		use "qemu_softmmu_targets_${target}" && \
		softmmu_targets="${softmmu_targets} ${target}-softmmu"
	done

	for target in ${IUSE_USER_TARGETS} ; do
		use "qemu_user_targets_${target}" && \
		user_targets="${user_targets} ${target}-linux-user"
	done

	if [ -z "${softmmu_targets}" ]; then
		conf_opts="${conf_opts} --disable-system"
	else
		einfo "Building the following softmmu targets: ${softmmu_targets}"
	fi

	if [ ! -z "${user_targets}" ]; then
		einfo "Building the following user targets: ${user_targets}"
		conf_opts="${conf_opts} --enable-linux-user"
	else
		conf_opts="${conf_opts} --disable-linux-user"
	fi

	# Fix QA issues. QEMU needs executable heaps and we need to mark it as such
	conf_opts="${conf_opts} --extra-ldflags=-Wl,-z,execheap"

	# Add support for static builds
	use static && conf_opts="${conf_opts} --static"

	# Fix the $(prefix)/etc issue
	conf_opts="${conf_opts} --sysconfdir=/etc"

	#config options
	conf_opts="${conf_opts} $(use_enable aio linux-aio)"
	conf_opts="${conf_opts} $(use_enable bluetooth bluez)"
	conf_opts="${conf_opts} $(use_enable brltty brlapi)"
	conf_opts="${conf_opts} $(use_enable curl)"
	conf_opts="${conf_opts} $(use_enable fdt)"
	conf_opts="${conf_opts} $(use_enable hardened pie)"
	conf_opts="${conf_opts} $(use_enable jpeg vnc-jpeg)"
	conf_opts="${conf_opts} $(use_enable ncurses curses)"
	conf_opts="${conf_opts} $(use_enable nss smartcard-nss)"
	conf_opts="${conf_opts} $(use_enable qemu_softmmu_targets_lm32 opengl)" # single opengl user
	conf_opts="${conf_opts} $(use_enable png vnc-png)"
	conf_opts="${conf_opts} $(use_enable rbd)"
	conf_opts="${conf_opts} $(use_enable sasl vnc-sasl)"
	conf_opts="${conf_opts} $(use_enable sdl)"
	conf_opts="${conf_opts} $(use_enable spice)"
	conf_opts="${conf_opts} $(use_enable ssl vnc-tls)"
	conf_opts="${conf_opts} $(use_enable threads vnc-thread)"
	conf_opts="${conf_opts} $(use_enable vde)"
	conf_opts="${conf_opts} $(use_enable vhost-net)"
	conf_opts="${conf_opts} $(use_enable xen)"
	conf_opts="${conf_opts} $(use_enable xattr attr)"
	conf_opts="${conf_opts} --disable-darwin-user --disable-bsd-user"

	# audio options
	audio_opts="oss"
	use alsa && audio_opts="alsa ${audio_opts}"
	use esd && audio_opts="esd ${audio_opts}"
	use pulseaudio && audio_opts="pa ${audio_opts}"
	use sdl && audio_opts="sdl ${audio_opts}"

	set -- --prefix=/usr \
		--disable-strip \
		--disable-werror \
		--disable-kvm \
		--enable-nptl \
		--enable-uuid \
		${conf_opts} \
		--audio-drv-list="${audio_opts}" \
		--target-list="${softmmu_targets} ${user_targets}" \
		--cc="$(tc-getCC)" \
		--host-cc="$(tc-getBUILD_CC)"

	echo ./configure "$@" # show actual options
	./configure "$@" || die "configure failed"
		# this is for qemu upstream's threaded support which is
		# in development and broken
		# the kvm project has its own support for threaded IO
		# which is always on and works
		# --enable-io-thread \
}

src_compile() {
	# Restricting parallel build until we get a patch to fix this
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if [ ! -z "${softmmu_targets}" ]; then
		exeinto /etc/qemu
		use qemu-ifup && { doexe \
			"${FILESDIR}/qemu-ifup" \
			"${FILESDIR}/qemu-ifdown" \
			|| die "qemu interface scripts missing" ; }
	fi

	dodoc Changelog MAINTAINERS TODO pci-ids.txt || die
	newdoc pc-bios/README README.pc-bios || die
	dohtml qemu-doc.html qemu-tech.html || die
}

pkg_postinst() {
	use qemu-ifup || return
	elog "You will need the Universal TUN/TAP driver compiled into your"
	elog "kernel or loaded as a module to use the virtual network device"
	elog "if using -net tap.  You will also need support for 802.1d"
	elog "Ethernet Bridging and a configured bridge if using the provided"
	elog "qemu-ifup script from /etc/qemu."
	echo
}
