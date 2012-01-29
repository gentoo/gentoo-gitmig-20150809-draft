# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wicd/wicd-1.7.1_pre20120127.ebuild,v 1.4 2012/01/29 12:23:34 phajdan.jr Exp $

EAPI=3

PYTHON_DEPEND="2"
PYTHON_USE_WITH="ncurses? xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit eutils distutils systemd

MY_PV="${PN}-1.7.1"
S="${WORKDIR}/${MY_PV}"

DESCRIPTION="A lightweight wired and wireless network manager for Linux"
HOMEPAGE="http://wicd.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~tomka/files/${P}.tar.gz
	mac4lin? ( http://dev.gentoo.org/~anarchy/dist/wicd-mac4lin-icons.tar.xz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="X +gtk ioctl libnotify mac4lin ncurses nls +pm-utils"

DEPEND=""
# Maybe virtual/dhcp would work, but there are enough problems with
# net-misc/dhcp that I want net-misc/dhcpcd to be guarenteed to be considered
# first if none are installed.
RDEPEND="
	dev-python/dbus-python
	X? ( gtk? ( dev-python/pygtk
		|| (
			x11-libs/gksu
			kde-base/kdesu
			)
		)
	)
	|| (
		net-misc/dhcpcd
		net-misc/dhcp
		net-misc/pump
	)
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	|| (
		sys-apps/net-tools
		sys-apps/ethtool
	)
	!gtk? ( dev-python/pygobject:2 )
	ioctl? ( dev-python/python-iwscan dev-python/python-wpactrl )
	libnotify? ( dev-python/notify-python )
	ncurses? (
		dev-python/urwid
		dev-python/pygobject:2
	)
	pm-utils? ( >=sys-power/pm-utils-1.1.1 )
	"
DOCS="CHANGES NEWS AUTHORS README"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.7.1_beta2-init.patch
	epatch "${FILESDIR}"/${PN}-init-sve-start.patch
	# Add a template for hex psk's and wpa (Bug 306423)
	epatch "${FILESDIR}"/${PN}-1.7.1_pre20111210-wpa-psk-hex-template.patch
	# get rid of opts variable to fix bug 381885
	sed -i "/opts/d" "in/init=gentoo=wicd.in" || die
	# Need to ensure that generated scripts use Python 2 at run time.
	sed -e "s:self.python = '/usr/bin/python':self.python = '/usr/bin/python2':" \
	  -i setup.py || die "sed failed"
	python_copy_sources
}

src_configure() {
	local myconf
	use gtk || myconf="${myconf} --no-install-gtk"
	use libnotify || myconf="${myconf} --no-use-notifications"
	use ncurses || myconf="${myconf} --no-install-ncurses"
	use pm-utils || myconf="${myconf} --no-install-pmutils"
	configuration() {
		$(PYTHON) ./setup.py configure --no-install-docs --resume=/usr/share/wicd/scripts/ --suspend=/usr/share/wicd/scripts/ --verbose ${myconf}
	}
	python_execute_function -s configuration
}

src_install() {
	distutils_src_install
	keepdir /var/lib/wicd/configurations \
		|| die "keepdir failed, critical for this app"
	keepdir /etc/wicd/scripts/{postconnect,disconnect,preconnect} \
		|| die "keepdir failed, critical for this app"
	keepdir /var/log/wicd \
		|| die "keepdir failed, critical for this app"
	use nls || rm -rf "${D}"/usr/share/locale
	systemd_dounit "${S}/other/wicd.service"

	if use mac4lin; then
		rm -rf "${D}"/usr/share/pixmaps/wicd || die "Failed to remove old icons"
		mv "${WORKDIR}"/wicd "${D}"/usr/share/pixmaps/
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "You may need to restart the dbus service after upgrading wicd."
	echo
	elog "To start wicd at boot, add /etc/init.d/wicd to a runlevel and:"
	elog "- Remove all net.* initscripts (except for net.lo) from all runlevels"
	elog "- Add these scripts to the RC_PLUG_SERVICES line in /etc/rc.conf"
	elog "(For example, rc_hotplug=\"!net.eth* !net.wlan*\")"
	# Maintainer's note: the consolekit use flag short circuits a dbus rule and
	# allows the connection. Else, you need to be in the group.
	if ! has_version sys-auth/pambase[consolekit]; then
			ewarn "Wicd-1.6 and newer requires your user to be in the 'users' group. If"
			ewarn "you are not in that group, then modify /etc/dbus-1/system.d/wicd.conf"
	fi
}
