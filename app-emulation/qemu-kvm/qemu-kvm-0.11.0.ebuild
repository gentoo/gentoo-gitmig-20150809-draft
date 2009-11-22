# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-kvm/qemu-kvm-0.11.0.ebuild,v 1.2 2009/11/22 23:31:47 cardoe Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs linux-info

SRC_URI="mirror://sourceforge/kvm/${P}.tar.gz"

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools"
HOMEPAGE="http://www.linux-kvm.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa bluetooth esd gnutls ncurses pulseaudio sasl +sdl vde"

COMMON_TARGETS="i386 x86_64 arm cris m68k mips mipsel mips64 mips64el ppc \
ppc64 sh4 sh4eb sparc"

IUSE_SOFTMMU_TARGETS="${COMMON_TARGETS} ppcemb"
IUSE_USER_TARGETS="${COMMON_TARGETS} alpha armeb ppc64abi32 sparc64 sparc32plus"

for target in ${IUSE_SOFTMMU_TARGETS}; do
	IUSE="${IUSE} +qemu_softmmu_targets_${target}"
done

for target in ${IUSE_USER_TARGETS}; do
	IUSE="${IUSE} +qemu_user_targets_${target}"
done


RESTRICT="test"

RDEPEND="sys-libs/zlib
	sys-apps/pciutils
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	bluetooth? ( net-wireless/bluez )
	esd? ( media-sound/esound )
	gnutls? ( net-libs/gnutls )
	ncurses? ( sys-libs/ncurses )
	pulseaudio? ( media-sound/pulseaudio )
	sasl? ( dev-libs/cyrus-sasl )
	sdl? ( >=media-libs/libsdl-1.2.11[X] )
	vde? ( net-misc/vde )
	!app-emulation/qemu-softmmu
	!app-emulation/qemu-user
	!app-emulation/qemu
	!app-emulation/kqemu"

DEPEND="${RDEPEND}
	app-text/texi2html
	>=sys-kernel/linux-headers-2.6.29
	gnutls? ( dev-util/pkgconfig )"

pkg_setup() {
	if kernel_is lt 2 6 25; then
		eerror "This version of KVM requres a host kernel of 2.6.25 or higher."
		eerror "Either upgrade your kernel"
		die "qemu-kvm version not compatible"
	elif ! linux_chkconfig_present KVM; then
		eerror "Please enable KVM support in your kernel, found at:"
		eerror
		eerror "  Virtualization"
		eerror "    Kernel-based Virtual Machine (KVM) support"
		eerror
		eerror "or enable the 'modules' USE flag."
		die "KVM support not detected!"
	fi

	enewgroup kvm
}

src_prepare() {
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
	# append CFLAGS while linking
	sed -i 's/$(LDFLAGS)/$(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS)/' rules.mak

	# remove part to make udev happy
	sed -e 's~NAME="%k", ~~' -i kvm/scripts/65-kvm.rules

	epatch "${FILESDIR}/qemu-0.11.0-mips64-user-fix.patch"
}

src_configure() {
	local conf_opts audio_opts softmmu_targets user_targets

	for target in ${IUSE_SOFTMMU_TARGETS} ; do
		use "qemu_softmmu_targets_${target}" && \
		softmmu_targets="${softmmu_targets} ${target}-softmmu"
	done

	for target in ${IUSE_USER_TARGETS} ; do
		use "qemu_user_targets_${target}" && \
		user_targets="${user_targets} ${target}-linux-user"
	done

	if [ ! -z "${softmmu_targets}" ]; then
		einfo "Building the following softmmu targets: ${softmmu_targets}"
	fi

	if [ ! -z "${user_targets}" ]; then
		einfo "Building the following user targets: ${user_targets}"
		conf_opts="${conf_opts} --enable-linux-user"
	else
		conf_opts="${conf_opts} --disable-linux-user"	
	fi

	#config options
	use gnutls || conf_opts="$conf_opts --disable-vnc-tls"
	use ncurses || conf_opts="$conf_opts --disable-curses"
	use sdl || conf_opts="$conf_opts --disable-sdl"
	use vde || conf_opts="$conf_opts --disable-vde"
	use bluetooth || conf_opts="$conf_opts --disable-bluez"
	use sasl || conf_opts='$conf_opts --disable-vnc-sasl"
	conf_opts="--disable-darwin-user --disable-bsd-user"

	# audio options
	audio_opts="oss"
	use alsa && audio_opts="alsa $audio_opts"
	use esd && audio_opts="esd $audio_opts"
	use pulseaudio && audio_opts="pa $audio_opts"
	use sdl && audio_opts="sdl $audio_opts"

	./configure --prefix=/usr \
		--disable-strip \
		--disable-xen \
		${conf_opts} \
		--audio-drv-list="$audio_opts" \
		--target-list="${softmmu_targets} ${user_targets}" \
		--cc=$(tc-getCC) \
		--host-cc=$(tc-getCC) \
		|| die "configure failed"
}

src_compile() {
	local mycc=$(cat config-host.mak | egrep "^CC=" | cut -d "=" -f 2)

	filter-flags -fpie -fstack-protector

	# If using gentoo's compiler set the SPEC to non-hardened
	if [ ! -z ${GCC_SPECS} -a -f ${GCC_SPECS} ]; then
		local myccver=$(${mycc} -dumpversion)
		local gccver=$($(tc-getBUILD_CC) -dumpversion)

		#Is this a SPEC for the right compiler version?
		myspec="${GCC_SPECS/${gccver}/${myccver}}"
		if [ "${myspec}" == "${GCC_SPECS}" ]; then
			shopt -s extglob
			GCC_SPECS="${GCC_SPECS/%hardened*specs/vanilla.specs}"
			shopt -u extglob
		else
			unset GCC_SPECS
		fi
	fi

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	insinto /etc/udev/rules.d/
	doins kvm/scripts/65-kvm.rules

	insinto /etc/kvm/
	insopts -m0755
	newins kvm/scripts/qemu-ifup kvm-ifup
	newins kvm/scripts/qemu-ifdown kvm-ifdown

	dodoc Changelog MAINTAINERS TODO pci-ids.txt || die
	newdoc pc-bios/README README.pc-bios || die
	dohtml qemu-doc.html qemu-tech.html
}

pkg_postinst() {
	elog "If you don't have kvm compiled into the kernel, make sure you have"
	elog "the kernel module loaded before running kvm. The easiest way to"
	elog "ensure that the kernel module is loaded is to load it on boot."
	elog "For AMD CPUs the module is called 'kvm-amd'"
	elog "For Intel CPUs the module is called 'kvm-intel'"
	elog "Please review /etc/conf.d/modules for how to load these"
	elog
	elog "Make sure your user is in the 'kvm' group"
	elog "Just run 'gpasswd -a <USER> kvm', then have <USER> re-login."
	elog
	elog "You will need the Universal TUN/TAP driver compiled into your"
	elog "kernel or loaded as a module to use the virtual network device"
	elog "if using -net tap.  You will also need support for 802.1d"
	elog "Ethernet Bridging and a configured bridge if using the provided"
	elog "kvm-ifup script from /etc/kvm."
	echo
}
