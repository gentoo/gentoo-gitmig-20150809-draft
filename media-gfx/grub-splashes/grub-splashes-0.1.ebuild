# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/grub-splashes/grub-splashes-0.1.ebuild,v 1.1 2007/07/05 05:05:40 welp Exp $

DESCRIPTION="Collection of grub splashes"
HOMEPAGE="http://www.gentoo.org/proj/en/desktop/artwork/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( sys-boot/grub sys-boot/grub-static )"
RDEPEND="${RDEPEND}"

src_install() {
	cd "$S"

	if [[ -d /boot/grub ]]; then
		insinto /boot/grub
		doins *.xpm.gz
	else
		die "/boot/grub/ does not exist, please make sure you have /boot mounted"
	fi
}

pkg_postinst() {
	elog "Please note that this ebuild makes the assumption that you're"
	elog "using /boot/grub/ for your grub configuration."
	elog ""
	elog "To your new grub splashes edit your /boot/grub/grub.conf"
	elog "You can see available splash screens by running"
	elog "\`ls /boot/grub/ | grep xpm\`"
}
