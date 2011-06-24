# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/systemd/systemd-29-r1.ebuild,v 1.1 2011/06/24 07:15:58 mgorny Exp $

EAPI=4

inherit autotools-utils bash-completion linux-info pam

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/systemd"
SRC_URI="http://www.freedesktop.org/software/systemd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="audit cryptsetup gtk pam plymouth selinux tcpd"

COMMON_DEPEND=">=sys-apps/dbus-1.4.10
	>=sys-fs/udev-171
	>=sys-apps/util-linux-2.19
	sys-libs/libcap
	audit? ( >=sys-process/audit-2 )
	cryptsetup? ( sys-fs/cryptsetup )
	gtk? (
		dev-libs/dbus-glib
		>=dev-libs/glib-2.26
		x11-libs/gtk+:2
		>=x11-libs/libnotify-0.7 )
	pam? ( virtual/pam )
	plymouth? ( sys-boot/plymouth )
	selinux? ( sys-libs/libselinux )
	tcpd? ( sys-apps/tcp-wrappers )"

# Vala-0.10 doesn't work with libnotify 0.7.1
VALASLOT="0.12"
# A little higher than upstream requires
# but I had real trouble with 2.6.37 and systemd.
MINKV="2.6.38"

# dbus, udev versions because of systemd units
# blocker on old packages to avoid collisions with above
# openrc blocker to avoid udev rules starting openrc scripts
RDEPEND="${COMMON_DEPEND}
	!!sys-apps/systemd-dbus
	!!sys-apps/systemd-udev
	!<sys-apps/openrc-0.8.3"
DEPEND="${COMMON_DEPEND}
	gtk? ( dev-lang/vala:${VALASLOT} )
	>=sys-kernel/linux-headers-${MINKV}"

pkg_pretend() {
	local CONFIG_CHECK="AUTOFS4_FS CGROUPS DEVTMPFS ~FANOTIFY ~IPV6"
	linux-info_pkg_setup
	kernel_is -ge ${MINKV//./ } || die "Kernel version at least ${MINKV} required"
}

pkg_setup() {
	enewgroup lock # used by var-lock.mount
	enewgroup tty 5 # used by mount-setup for /dev/pts
}

src_prepare() {
	# Force the rebuild of .vala sources
	touch src/*.vala || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--with-distro=gentoo
		--with-rootdir=
		--localstatedir=/var
		--docdir=/tmp/docs
		$(use_enable audit)
		$(use_enable cryptsetup libcryptsetup)
		$(use_enable gtk)
		$(use_enable pam)
		$(use_enable selinux)
		$(use_enable tcpd tcpwrap)

		# right now it is enabled on per-distro basis
		# let's just hack into the check
		$(use plymouth && echo have_plymouth=true)
	)

	if use gtk; then
		export VALAC="$(type -p valac-${VALASLOT})"
	fi

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install \
		bashcompletiondir=/tmp

	# move files as necessary
	dobashcompletion "${D}"/tmp/systemctl-bash-completion.sh
	dodoc "${D}"/tmp/docs/*
	rm -rf "${D}"/tmp || die

	cd "${D}"/usr/share/man/man8/
	for i in halt poweroff reboot runlevel shutdown telinit; do
		mv ${i}.8 systemd.${i}.8 || die
	done

	# Drop the .pc file to avoid automagic depends.
	# This a temporary workaround for gx86 packages.
	rm -f "${D}"/usr/share/pkgconfig/systemd.pc || die

	keepdir /run
}

pkg_postinst() {
	if [[ ! -L "${ROOT}"etc/mtab ]]; then
		ewarn "Upstream suggests that the /etc/mtab file should be a symlink to /proc/mounts."
		ewarn "It is known to cause users being unable to unmount user mounts. If you don't"
		ewarn "require that specific feature, please call:"
		ewarn "	$ ln -sf '${ROOT}proc/self/mounts' '${ROOT}etc/mtab'"
		ewarn
	fi

	elog "You may need to perform some additional configuration for some programs"
	elog "to work, see the systemd manpages for loading modules and handling tmpfiles:"
	elog "	$ man modules-load.d"
	elog "	$ man tmpfiles.d"
	elog

	ewarn "Please note this is a work-in-progress and many packages in Gentoo"
	ewarn "do not supply systemd unit files yet. You are testing it on your own"
	ewarn "responsibility. Please remember than you can pass:"
	ewarn "	init=/sbin/init"
	ewarn "to your kernel to boot using sysvinit / OpenRC."
}
