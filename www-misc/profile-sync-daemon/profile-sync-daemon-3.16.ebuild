# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/profile-sync-daemon/profile-sync-daemon-3.16.ebuild,v 1.1 2012/10/16 21:48:39 hasufell Exp $

EAPI=4

inherit eutils vcs-snapshot

DESCRIPTION="Symlinks and syncs browser profile dirs to RAM"
HOMEPAGE="https://wiki.archlinux.org/index.php/Profile-sync-daemon"
SRC_URI="https://github.com/hasufell/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cron"

RDEPEND="
	app-shells/bash
	net-misc/rsync
	cron? ( virtual/cron )"

src_install() {
	emake DESTDIR="${D}" $(usex cron "install" "install-bin install-doc install-man")
}
