# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-kvm/qemu-kvm-1.0-r1.ebuild,v 1.2 2012/01/25 06:02:34 cardoe Exp $

#BACKPORTS=1

EAPI="3"

if [[ ${PV} = *9999* ]]; then
#	EGIT_REPO_URI="git://git.kernel.org/pub/scm/virt/kvm/qemu-kvm.git"
	EGIT_REPO_URI="git://github.com/avikivity/kvm.git"
	GIT_ECLASS="git-2"
fi

inherit eutils flag-o-matic ${GIT_ECLASS} linux-info toolchain-funcs multilib python

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/kvm/${PN}/${P}.tar.gz
	${BACKPORTS:+
		http://dev.gentoo.org/~flameeyes/${PN}/${P}-backports-${BACKPORTS}.tar.bz2
		http://dev.gentoo.org/~cardoe/distfiles/${P}-backports-${BACKPORTS}.tar.bz2}"
	KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
fi

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools"
HOMEPAGE="http://www.linux-kvm.org"

LICENSE="GPL-2"
SLOT="0"
# xen is disabled until the deps are fixed
IUSE="+aio alsa bluetooth brltty curl debug esd fdt hardened jpeg ncurses nss \
opengl png pulseaudio qemu-ifup rbd sasl sdl spice ssl threads vde \
+vhost-net xattr xen"
# static, depends on libsdl being built with USE=static-libs, which can not
# be expressed in current EAPI's

COMMON_TARGETS="i386 x86_64 arm cris m68k microblaze mips mipsel ppc ppc64 sh4 sh4eb sparc sparc64"
IUSE_SOFTMMU_TARGETS="${COMMON_TARGETS} mips64 mips64el ppcemb"
IUSE_USER_TARGETS="${COMMON_TARGETS} alpha armeb ppc64abi32 sparc32plus"

# Setup the default SoftMMU targets, while using the loops
# below to setup the other targets. x86_64 should be the only
# defaults on for qemu-kvm
IUSE="${IUSE} +qemu_softmmu_targets_x86_64"

for target in ${IUSE_SOFTMMU_TARGETS}; do
	if [ "x${target}" = "xx86_64" ]; then
		continue
	fi
	IUSE="${IUSE} qemu_softmmu_targets_${target}"
done

for target in ${IUSE_USER_TARGETS}; do
	IUSE="${IUSE} qemu_user_targets_${target}"
done

RESTRICT="test"

RDEPEND="
	!app-emulation/kqemu
	!app-emulation/qemu
	!app-emulation/qemu-user
	>=dev-libs/glib-2.0
	sys-apps/pciutils
	>=sys-apps/util-linux-2.16.0
	sys-libs/zlib
	amd64? ( sys-apps/seabios
		sys-apps/vgabios )
	x86? ( sys-apps/seabios
		sys-apps/vgabios )
	aio? ( dev-libs/libaio )
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	bluetooth? ( net-wireless/bluez )
	brltty? ( app-accessibility/brltty )
	curl? ( >=net-misc/curl-7.15.4 )
	esd? ( media-sound/esound )
	fdt? ( >=sys-apps/dtc-1.2.0 )
	jpeg? ( virtual/jpeg )
	ncurses? ( sys-libs/ncurses )
	nss? ( dev-libs/nss )
	opengl? ( virtual/opengl )
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
"

DEPEND="${RDEPEND}
	app-text/texi2html
	dev-util/pkgconfig
	>=sys-kernel/linux-headers-2.6.35"

STRIP_MASK="/usr/share/qemu/palcode-clipper"

QA_PRESTRIPPED="
	usr/share/qemu/openbios-ppc
	usr/share/qemu/openbios-sparc64
	usr/share/qemu/openbios-sparc32
	usr/share/qemu/palcode-clipper"

QA_WX_LOAD="${QA_PRESTRIPPED}
	usr/bin/qemu-i386
	usr/bin/qemu-x86_64
	usr/bin/qemu-alpha
	usr/bin/qemu-arm
	usr/bin/qemu-cris
	usr/bin/qemu-m68k
	usr/bin/qemu-microblaze
	usr/bin/qemu-mips
	usr/bin/qemu-mipsel
	usr/bin/qemu-ppc
	usr/bin/qemu-ppc64
	usr/bin/qemu-ppc64abi32
	usr/bin/qemu-sh4
	usr/bin/qemu-sh4eb
	usr/bin/qemu-sparc
	usr/bin/qemu-sparc64
	usr/bin/qemu-armeb
	usr/bin/qemu-sparc32plus"

kvm_kern_warn() {
	eerror "Please enable KVM support in your kernel, found at:"
	eerror
	eerror "  Virtualization"
	eerror "    Kernel-based Virtual Machine (KVM) support"
	eerror
}

pkg_pretend() {
	if ! use qemu_softmmu_targets_x86_64 && use amd64 ; then
		eerror "You disabled default target QEMU_SOFTMMU_TARGETS=x86_64"
	fi

	if ! use qemu_softmmu_targets_x86_64 && use x86 ; then
		eerror "You disabled default target QEMU_SOFTMMU_TARGETS=x86_64"
	fi

	if kernel_is lt 2 6 25; then
		eerror "This version of KVM requres a host kernel of 2.6.25 or higher."
		eerror "Either upgrade your kernel"
	else
		if ! linux_config_exists; then
			eerror "Unable to check your kernel for KVM support"
			kvm_kern_warn
		elif ! linux_chkconfig_present KVM; then
			kvm_kern_warn
		fi
		if use vhost-net && ! linux_chkconfig_present VHOST_NET ; then
			ewarn "You have to enable CONFIG_VHOST_NET in the kernel"
			ewarn "to have vhost-net support."
		fi
	fi
}

pkg_setup() {

	python_set_active_version 2

	enewgroup kvm
}

src_prepare() {
	# prevent docs to get automatically installed
	sed -i '/$(DESTDIR)$(docdir)/d' Makefile || die
	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target || die
	# append CFLAGS while linking
	sed -i 's/$(LDFLAGS)/$(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS)/' rules.mak || die

	# remove part to make udev happy
	sed -e 's~NAME="%k", ~~' -i kvm/scripts/65-kvm.rules || die

	# ${PN}-guest-hang-on-usb-add.patch was sent by Timothy Jones
	# to the qemu-devel ml - bug 337988
	epatch "${FILESDIR}/qemu-0.11.0-mips64-user-fix.patch"

	epatch "${FILESDIR}"/${PN}-1.0-per-target-i8259.patch #400597
	epatch "${FILESDIR}"/${PN}-1.0-fix-nonkvm-arches.patch
	epatch "${FILESDIR}"/${PN}-1.0-fix-qemu-system-ppc.patch

	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch
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
		eerror "All SoftMMU targets are disabled. This is invalid for qemu-kvm"
		die "At least 1 SoftMMU target must be enabled"
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
	#use static && conf_opts="${conf_opts} --static"

	# Support debug USE flag
	use debug && conf_opts="${conf_opts} --enable-debug --disable-strip"

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
	conf_opts="${conf_opts} $(use_enable opengl)"
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
	./configure --prefix=/usr \
		--disable-strip \
		--disable-werror \
		--enable-kvm \
		--enable-nptl \
		--enable-uuid \
		${conf_opts} \
		--audio-drv-list="${audio_opts}" \
		--target-list="${softmmu_targets} ${user_targets}" \
		--cc="$(tc-getCC)" \
		--host-cc="$(tc-getBUILD_CC)" \
		|| die "configure failed"

		# this is for qemu upstream's threaded support which is
		# in development and broken
		# the kvm project has its own support for threaded IO
		# which is always on and works
		# --enable-io-thread \
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if [ ! -z "${softmmu_targets}" ]; then
		insinto /lib/udev/rules.d/
		doins kvm/scripts/65-kvm.rules || die

		if use qemu-ifup; then
			insinto /etc/qemu/
			insopts -m0755
			doins kvm/scripts/qemu-ifup || die
		fi

		if use qemu_softmmu_targets_x86_64 ; then
			dobin "${FILESDIR}"/qemu-kvm
			dosym /usr/bin/qemu-kvm /usr/bin/kvm
		else
			elog "You disabled QEMU_SOFTMMU_TARGETS=x86_64, this disables install"
			elog "of /usr/bin/qemu-kvm and /usr/bin/kvm"
		fi
	fi

	dodoc Changelog MAINTAINERS TODO pci-ids.txt || die
	newdoc pc-bios/README README.pc-bios || die
	dohtml qemu-doc.html qemu-tech.html || die

	# FIXME: Need to come up with a solution for non-x86 based systems
	if use x86 || use amd64; then
		# Remove SeaBIOS since we're using the SeaBIOS packaged one
		rm "${D}/usr/share/qemu/bios.bin"
		dosym ../seabios/bios.bin /usr/share/qemu/bios.bin

		# Remove vgabios since we're using the vgabios packaged one
		rm "${D}/usr/share/qemu/vgabios.bin"
		rm "${D}/usr/share/qemu/vgabios-cirrus.bin"
		rm "${D}/usr/share/qemu/vgabios-qxl.bin"
		rm "${D}/usr/share/qemu/vgabios-stdvga.bin"
		rm "${D}/usr/share/qemu/vgabios-vmware.bin"
		dosym ../vgabios/vgabios.bin /usr/share/qemu/vgabios.bin
		dosym ../vgabios/vgabios-cirrus.bin /usr/share/qemu/vgabios-cirrus.bin
		dosym ../vgabios/vgabios-qxl.bin /usr/share/qemu/vgabios-qxl.bin
		dosym ../vgabios/vgabios-stdvga.bin /usr/share/qemu/vgabios-stdvga.bin
		dosym ../vgabios/vgabios-vmware.bin /usr/share/qemu/vgabios-vmware.bin
	fi
}

pkg_postinst() {

	if [ ! -z "${softmmu_targets}" ]; then
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
		elog
		elog "The gnutls use flag was renamed to ssl, so adjust your use flags."
	fi
}
