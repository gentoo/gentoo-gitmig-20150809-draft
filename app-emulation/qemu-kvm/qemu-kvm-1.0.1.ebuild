# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-kvm/qemu-kvm-1.0.1.ebuild,v 1.5 2012/05/09 14:39:57 phajdan.jr Exp $

#BACKPORTS=1

EAPI="4"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/virt/kvm/qemu-kvm.git"
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
	KEYWORDS="amd64 ~ppc ~ppc64 x86"
fi

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools"
HOMEPAGE="http://www.linux-kvm.org"

LICENSE="GPL-2"
SLOT="0"
# xen is disabled until the deps are fixed
IUSE="+aio alsa bluetooth brltty +curl debug fdt ncurses \
opengl pulseaudio qemu-ifup rbd sasl sdl smartcard spice static test
+threads tls usbredir vde +vhost-net xattr xen"

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

RDEPEND="
	!app-emulation/kqemu
	!app-emulation/qemu
	!app-emulation/qemu-user
	>=dev-libs/glib-2.0
	media-libs/libpng
	sys-apps/pciutils
	>=sys-apps/util-linux-2.16.0
	virtual/jpeg
	amd64? ( sys-apps/seabios
		sys-apps/vgabios )
	x86? ( sys-apps/seabios
		sys-apps/vgabios )
	aio? ( dev-libs/libaio )
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	bluetooth? ( net-wireless/bluez )
	brltty? ( app-accessibility/brltty )
	curl? ( >=net-misc/curl-7.15.4 )
	fdt? ( >=sys-apps/dtc-1.2.0 )
	ncurses? ( sys-libs/ncurses )
	opengl? ( virtual/opengl )
	pulseaudio? ( media-sound/pulseaudio )
	qemu-ifup? ( sys-apps/iproute2 net-misc/bridge-utils )
	rbd? ( sys-cluster/ceph )
	sasl? ( dev-libs/cyrus-sasl )
	sdl? ( static? ( >=media-libs/libsdl-1.2.11[static-libs,X] )
		!static? ( >=media-libs/libsdl-1.2.11[X] ) )
	static? ( sys-libs/zlib[static-libs(+)] )
	!static? ( sys-libs/zlib )
	smartcard? ( dev-libs/nss )
	spice? ( >=app-emulation/spice-0.9.0
			>=app-emulation/spice-protocol-0.8.1 )
	tls? ( net-libs/gnutls )
	usbredir? ( sys-apps/usbredir )
	vde? ( net-misc/vde )
	xattr? ( sys-apps/attr )
	xen? ( app-emulation/xen-tools )
"

DEPEND="${RDEPEND}
	app-text/texi2html
	virtual/pkgconfig
	>=sys-kernel/linux-headers-2.6.35
	test? ( dev-libs/check )"

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
		else
			CONFIG_CHECK="~KVM ~TUN ~BRIDGE"
			ERROR_KVM="You must enable KVM in your kernel to continue"
			ERROR_KVM_AMD="If you have an AMD CPU, you must enable KVM_AMD in"
			ERROR_KVM_AMD+=" your kernel configuration."
			ERROR_KVM_INTEL="If you have an Intel CPU, you must enable"
			ERROR_KVM_INTEL+=" KVM_INTEL in your kernel configuration."
			ERROR_TUN="You will need the Universal TUN/TAP driver compiled"
			ERROR_TUN+=" into your kernel or loaded as a module to use the"
			ERROR_TUN+=" virtual network device if using -net tap."
			ERROR_BRIDGE="You will also need support for 802.1d"
			ERROR_BRIDGE+=" Ethernet Bridging for some network configurations."
			use vhost-net && CHECK_CHECK+=" ~VHOST_NET"
			ERROR_VHOST_NET="You must enable VHOST_NET to have vhost-net"
			ERROR_VHOST_NET+=" support"

			if use amd64 || use x86 || use amd64-linux || use x86-linux; then
				CONFIG_CHECK+=" ~KVM_AMD ~KVM_INTEL"
			fi

			# Now do the actual checks setup above
			check_extra_config
		fi
	fi
}

pkg_setup() {
	python_set_active_version 2

	enewgroup kvm 78
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

	# Fix compilation of the qemu-system-ppc component
	epatch "${FILESDIR}"/${PN}-1.0-fix-qemu-system-ppc.patch

	# drop '-g' by default as it tends to eat
	# A LOT (~2GB) of ram for each job #355861
	sed -e 's/CFLAGS="-g $CFLAGS"/CFLAGS="$CFLAGS"/g' \
		-i configure || die

	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	epatch_user
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

	if [[ -z ${softmmu_targets} ]]; then
		eerror "All SoftMMU targets are disabled. This is invalid for qemu-kvm"
		die "At least 1 SoftMMU target must be enabled"
	else
		einfo "Building the following softmmu targets: ${softmmu_targets}"
	fi

	if [[ -n ${user_targets} ]]; then
		einfo "Building the following user targets: ${user_targets}"
		conf_opts="${conf_opts} --enable-linux-user"
	else
		conf_opts="${conf_opts} --disable-linux-user"
	fi

	# Fix QA issues. QEMU needs executable heaps and we need to mark it as such
	conf_opts="${conf_opts} --extra-ldflags=-Wl,-z,execheap"

	# Add support for static builds
	use static && conf_opts="${conf_opts} --static"

	# Support debug USE flag
	use debug && conf_opts="${conf_opts} --enable-debug"

	# audio options
	audio_opts="oss"
	use alsa && audio_opts="alsa ${audio_opts}"
	use pulseaudio && audio_opts="pa ${audio_opts}"
	use sdl && audio_opts="sdl ${audio_opts}"

	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--disable-darwin-user \
		--disable-bsd-user \
		--disable-libiscsi \
		--disable-strip \
		--disable-werror \
		--enable-kvm \
		--enable-kvm-device-assignment \
		--enable-kvm-pit \
		--enable-pie \
		--enable-nptl \
		--enable-tcg-interpreter \
		--enable-uuid \
		--enable-vnc-jpeg \
		--enable-vnc-png \
		--python=python2 \
		$(use_enable aio linux-aio) \
		$(use_enable bluetooth bluez) \
		$(use_enable brltty brlapi) \
		$(use_enable curl) \
		$(use_enable fdt) \
		$(use_enable ncurses curses) \
		$(use_enable opengl) \
		$(use_enable rbd) \
		$(use_enable sasl vnc-sasl) \
		$(use_enable sdl) \
		$(use_enable smartcard smartcard) \
		$(use_enable smartcard smartcard-nss) \
		$(use_enable spice) \
		$(use_enable test check-utests) \
		$(use_enable tls vnc-tls) \
		$(use_enable threads vnc-thread) \
		$(use_enable usbredir usb-redir) \
		$(use_enable vde) \
		$(use_enable vhost-net) \
		$(use_enable xen) \
		$(use_enable xattr attr) \
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
	emake DESTDIR="${ED}" install || die "make install failed"

	if [[ -n ${softmmu_targets} ]]; then
		insinto /lib/udev/rules.d/
		doins kvm/scripts/65-kvm.rules || die

		if use qemu-ifup; then
			insinto /etc/qemu/
			insopts -m0755
			doins kvm/scripts/qemu-ifup || die
		fi

		if use qemu_softmmu_targets_x86_64 ; then
			dobin "${FILESDIR}"/qemu-kvm
			ewarn "The depreciated '/usr/bin/kvm' symlink is no longer installed"
			ewarn "You should use '/usr/bin/qemu-kvm', you may need to edit"
			ewarn "your libvirt configs or other wrappers for ${PN}"
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
		rm "${ED}/usr/share/qemu/bios.bin"
		dosym ../seabios/bios.bin /usr/share/qemu/bios.bin

		# Remove vgabios since we're using the vgabios packaged one
		rm "${ED}/usr/share/qemu/vgabios.bin"
		rm "${ED}/usr/share/qemu/vgabios-cirrus.bin"
		rm "${ED}/usr/share/qemu/vgabios-qxl.bin"
		rm "${ED}/usr/share/qemu/vgabios-stdvga.bin"
		rm "${ED}/usr/share/qemu/vgabios-vmware.bin"
		dosym ../vgabios/vgabios.bin /usr/share/qemu/vgabios.bin
		dosym ../vgabios/vgabios-cirrus.bin /usr/share/qemu/vgabios-cirrus.bin
		dosym ../vgabios/vgabios-qxl.bin /usr/share/qemu/vgabios-qxl.bin
		dosym ../vgabios/vgabios-stdvga.bin /usr/share/qemu/vgabios-stdvga.bin
		dosym ../vgabios/vgabios-vmware.bin /usr/share/qemu/vgabios-vmware.bin
	fi
}

pkg_postinst() {

	if [[ -n ${softmmu_targets} ]]; then
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
		elog "The ssl USE flag was renamed to tls, so adjust your USE flags."
		elog "The nss USE flag was renamed to smartcard, so adjust your USE flags."
	fi

	use qemu-ifup && \
	ewarn "qemu-ifup is deprecated, be prepared for it to disappear next release"
}
