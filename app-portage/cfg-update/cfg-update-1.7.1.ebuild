# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/cfg-update/cfg-update-1.7.1.ebuild,v 1.3 2005/08/17 16:57:13 truedfx Exp $

DESCRIPTION="Easy to use GUI & CLI alternative for etc-update with safe auto-updating"
HOMEPAGE="http://people.zeelandnet.nl/xentric/"
SRC_URI="http://people.zeelandnet.nl/xentric/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="kde gnome"
KEYWORDS="~amd64 ~x86"
RDEPEND="kde? (
		>=x11-misc/sux-1.0
		|| ( >=kde-misc/kdiff3-0.9
			>=dev-util/xxdiff-2.9 ) )
	gnome? (
		>=x11-misc/sux-1.0
		>=dev-util/meld-0.9 )"

pkg_postrm() {
	ewarn
	ewarn "You should manually disable the alias for emerge in /etc/profile"
	ewarn "and remove the index file /usr/lib/cfg-update/checksum-index"
	ewarn "if you are permanently removing cfg-update from your system."
	ewarn
}

src_install() {
	exeinto /usr/bin
	doexe cfg-update emerge_with_indexing_for_cfg-update
	exeinto /usr/lib/cfg-update
	doexe cfg-update
	insinto /usr/lib/cfg-update
	doins .bashrc .bash_profile .Xdefaults README COPYING ChangeLog
	doman *.8
}

pkg_postinst() {
	einfo
	einfo "Converting old configurationfile backups to new filename format..."
	cfg-update --convert 2>/dev/null
	einfo "Turning off old emerge alias in /etc/profile..."
	cfg-update --off >/dev/null
	einfo "Turning on new emerge alias in /etc/profile..."
	cfg-update --on >/dev/null
	einfo "Trying to build the checksum index for automatic updating..."
	cfg-update --index >/dev/null
	ewarn
	ewarn "Type \"source /etc/profile\" when this installation is finished to load the"
	ewarn "alias for emerge. If you do not want to use the auto-update function you can"
	ewarn "disable the emerge alias with \"cfg-update --off\"."
	ewarn
}
