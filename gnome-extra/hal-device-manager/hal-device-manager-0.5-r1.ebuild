# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hal-device-manager/hal-device-manager-0.5-r1.ebuild,v 1.6 2007/07/08 05:54:39 mr_bones_ Exp $

inherit eutils

DESCRIPTION="HAL device viewer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI=""

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-apps/hal-${PV}-r1
	|| ( >=dev-python/dbus-python-0.71
		>=sys-apps/dbus-0.60 )
	>=dev-python/gnome-python-2.0.0-r1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}

pkg_setup() {
	if [ ! -z $(best_version =sys-apps/dbus-0.62*) ]; then
		if ! built_with_use "=sys-apps/dbus-0.62*" python; then
			eerror 'Please rebuild dbus with the python useflag before installing'
			eerror 'this package.'
			eerror
			eerror "echo 'sys-apps/dbus python' >> /etc/portage/package.use"
			eerror 'emerge dbus'

			die "dbus python bindings unavailable"
		fi
	fi
}

src_install() {
	dodir /usr/bin
	dosym /usr/share/hal/device-manager/hal-device-manager /usr/bin

	make_desktop_entry hal-device-manager "Device Manager" \
		"hwbrowser" "System"
}
