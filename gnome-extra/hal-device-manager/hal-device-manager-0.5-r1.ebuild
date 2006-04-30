# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hal-device-manager/hal-device-manager-0.5-r1.ebuild,v 1.1 2006/04/30 20:12:39 compnerd Exp $

inherit eutils

DESCRIPTION="HAL device viewer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI=""

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-apps/hal-${PV}-r1
		 >=dev-python/gnome-python-2.0.0-r1"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

S=${WORKDIR}

pkg_setup() {
	if ! built_with_use '>=sys-apps/hal-${PV}-r1' 'python' ; then
		eerror 'Please rebuild hal with the python useflag before installing'
		eerror 'this package.'
		echo
		eerror "echo 'sys-apps/hal python' >> /etc/portage/package.use"
		eerror 'emerge hal'

		die "hal python bindings unavailable"
	fi
}

src_install() {
	dodir /usr/bin
	dosym /usr/share/hal/device-manager/hal-device-manager /usr/bin

	make_desktop_entry hal-device-manager "Device Manager" \
		"hwbrowser" "System"
}
