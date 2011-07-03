# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/plymouth-openrc-plugin/plymouth-openrc-plugin-0.1.1.ebuild,v 1.3 2011/07/03 11:44:51 aidecoe Exp $

EAPI=4

inherit multilib

DESCRIPTION="Plymouth plugin for OpenRC"
HOMEPAGE="https://github.com/aidecoe/plymouth-openrc-plugin"
SRC_URI="
http://dev.gentoo.org/~aidecoe/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=sys-apps/openrc-0.8.2-r1
	!<sys-boot/plymouth-0.8.3-r5
	"
RDEPEND="${DEPEND}
	>=sys-boot/plymouth-0.8.3-r5
	"

pkg_pretend() {
	if [[ ! -w /run ]]; then
		die "/run doesn't exist!  You need to create this directory.\n\n" \
		"If you'd like to know more about purpose of /run, please read:\n\n" \
		"  https://lwn.net/Articles/436012/\n"
	fi
}

src_install() {
	insinto /$(get_libdir)/rc/plugins
	doins plymouth.so
}

pkg_postinst() {
	ewarn "You need to disable 'interactive' feature in /etc/rc.conf to make"
	ewarn "Plymouth work properly with OpenRC init system."
}
