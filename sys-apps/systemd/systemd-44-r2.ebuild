# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/systemd/systemd-44-r2.ebuild,v 1.1 2012/08/09 14:54:00 mgorny Exp $

EAPI=4

inherit autotools-utils bash-completion-r1 linux-info pam systemd user

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/systemd"
SRC_URI="http://www.freedesktop.org/software/systemd/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="acl audit cryptsetup lzma pam selinux tcpd"

# We need to depend on sysvinit for sulogin which is used in the rescue
# mode. Bug #399615.

# A little higher than upstream requires
# but I had real trouble with 2.6.37 and systemd.
MINKV="2.6.38"

# dbus version because of systemd units
# sysvinit for sulogin
# new udev versions because they break randomly
RDEPEND=">=sys-apps/dbus-1.4.10
	>=sys-apps/kmod-5
	sys-apps/sysvinit
	>=sys-apps/util-linux-2.19
	<sys-fs/udev-187
	>=sys-fs/udev-172
	sys-libs/libcap
	acl? ( sys-apps/acl )
	audit? ( >=sys-process/audit-2 )
	cryptsetup? ( sys-fs/cryptsetup )
	lzma? ( app-arch/xz-utils )
	pam? ( virtual/pam )
	selinux? ( sys-libs/libselinux )
	tcpd? ( sys-apps/tcp-wrappers )"

DEPEND="${RDEPEND}
	app-arch/xz-utils
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/gperf
	dev-util/intltool
	>=sys-kernel/linux-headers-${MINKV}"

PATCHES=(
	# bug #408879: Session Logout File Deletion Weakness (CVE-2012-1174)
	"${FILESDIR}"/0001-util-never-follow-symlinks-in-rm_rf_children.patch
	# bug #410973: fails to build on ARM due to PAGE_SIZE not being defined
	"${FILESDIR}"/0002-journal-PAGE_SIZE-is-not-known-on-ppc-and-other-arch.patch
)

pkg_setup() {
	enewgroup lock # used by var-lock.mount
	enewgroup tty 5 # used by mount-setup for /dev/pts
}

src_prepare() {
	# systemd-analyze is for python2.7 only nowadays.
	sed -i -e '1s/python/&2.7/' src/systemd-analyze

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--with-distro=gentoo
		# install everything to /usr
		--with-rootprefix=/usr
		--with-rootlibdir=/usr/$(get_libdir)
		# but pam modules have to lie in /lib*
		--with-pamlibdir=/$(get_libdir)/security
		--localstatedir=/var
		# make sure we get /bin:/sbin in $PATH
		--enable-split-usr
		$(use_enable acl)
		$(use_enable audit)
		$(use_enable cryptsetup libcryptsetup)
		$(use_enable lzma xz)
		$(use_enable pam)
		$(use_enable selinux)
		$(use_enable tcpd tcpwrap)
		# now in sys-apps/systemd-ui
		--disable-gtk
		# removed in newer version, so no point in fixing it
		--disable-plymouth
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install \
		bashcompletiondir=/tmp

	# compat for init= use
	dosym ../usr/lib/systemd/systemd /bin/systemd
	dosym ../lib/systemd/systemd /usr/bin/systemd
	# rsyslog.service depends on it...
	dosym ../usr/bin/systemctl /bin/systemctl

	# move files as necessary
	newbashcomp "${D}"/tmp/systemd-bash-completion.sh ${PN}
	rm -r "${D}"/tmp || die

	# we just keep sysvinit tools, so no need for the mans
	rm "${D}"/usr/share/man/man8/{halt,poweroff,reboot,runlevel,shutdown,telinit}.8 \
		|| die
	rm "${D}"/usr/share/man/man1/init.1 || die
	# collision with -ui
	rm "${D}"/usr/share/man/man1/systemadm.1 || die

	# Create /run/lock as required by new baselay/OpenRC compat.
	insinto /usr/lib/tmpfiles.d
	doins "${FILESDIR}"/gentoo-run.conf

	# Migration helpers.
	exeinto /usr/libexec/systemd
	doexe "${FILESDIR}"/update-etc-systemd-symlinks.sh
	systemd_dounit "${FILESDIR}"/update-etc-systemd-symlinks.{service,path}
	systemd_enable_service sysinit.target update-etc-systemd-symlinks.path
}

pkg_preinst() {
	local CONFIG_CHECK="~AUTOFS4_FS ~CGROUPS ~DEVTMPFS ~FANOTIFY ~IPV6"
	kernel_is -ge ${MINKV//./ } || ewarn "Kernel version at least ${MINKV} required"
	check_extra_config
}

optfeature() {
	local i desc=${1} text
	shift

	text="  [\e[1m$(has_version ${1} && echo I || echo ' ')\e[0m] ${1}"
	shift

	for i; do
		elog "${text}"
		text="& [\e[1m$(has_version ${1} && echo I || echo ' ')\e[0m] ${1}"
	done
	elog "${text} (${desc})"
}

pkg_postinst() {
	mkdir -p "${ROOT}"/run || ewarn "Unable to mkdir /run, this could mean trouble."
	if [[ ! -L "${ROOT}"/etc/mtab ]]; then
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

	elog "To get additional features, a number of optional runtime dependencies may"
	elog "be installed:"
	optfeature 'for systemd-analyze' \
		'dev-lang/python:2.7' 'dev-python/dbus-python'
	optfeature 'for systemd-analyze plotting ability' \
		'dev-python/pycairo[svg]'
	optfeature 'for GTK+ systemadm UI and gnome-ask-password-agent' \
		'sys-apps/systemd-ui'
	elog

	ewarn "Please note this is a work-in-progress and many packages in Gentoo"
	ewarn "do not supply systemd unit files yet. You are testing it on your own"
	ewarn "responsibility. Please remember than you can pass:"
	ewarn "	init=/sbin/init"
	ewarn "to your kernel to boot using sysvinit / OpenRC."

	# Don't run it if we're outta /
	if [[ ! ${ROOT%/} ]]; then
		# Update symlinks to moved units.
		sh "${FILESDIR}"/update-etc-systemd-symlinks.sh

		# Try to start migration unit.
		ebegin "Trying to start migration helper path monitoring."
		systemctl --system start update-etc-systemd-symlinks.path 2>/dev/null
		eend ${?}
	fi
}
