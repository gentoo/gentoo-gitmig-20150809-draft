# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/bootsplash-themes-livecd/bootsplash-themes-livecd-2004.2.ebuild,v 1.1 2004/05/26 12:20:49 wolf31o2 Exp $

IUSE="livecd"
S=${WORKDIR}/${PF}
DESCRIPTION="Gentoo ${PV} theme for bootsplash consoles"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PF}.tar.bz2
	http://dev.gentoo.org/~wolf31o2/${PF}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="media-gfx/bootsplash"

src_install() {
	cp -r * ${D}/etc/bootsplash/themes/livecd-${PV}

	# link default config for boot images if not already set
	if [ ! -e ${ROOT}/etc/bootsplash/default ]; then
		use livecd \
			&& dosym ./livecd-${PV} /etc/bootsplash/default \
			|| dosym ./gentoo /etc/bootsplash/default
	fi
	use livecd && dosed "s:gentoo:livecd-${PV}:" /etc/conf.d/bootsplash
}
