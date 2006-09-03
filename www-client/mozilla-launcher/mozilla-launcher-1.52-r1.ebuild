# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-launcher/mozilla-launcher-1.52-r1.ebuild,v 1.1 2006/09/03 10:20:34 nelchael Exp $

inherit eutils

DESCRIPTION="Script that launches mozilla or firefox"
HOMEPAGE="http://dev.gentoo.org/~agriffis/dist/"
SRC_URI="mirror://gentoo/${P}.bz2
		http://dev.gentoo.org/~anarchy/dist/${P}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
IUSE="aoss"

DEPEND=""
RDEPEND="|| ( x11-apps/xdpyinfo virtual/x11 )
	aoss? ( media-libs/alsa-oss )"

S=${WORKDIR}

src_install() {
	use aoss && epatch "${FILESDIR}/${P}-aoss.patch"
	exeinto /usr/libexec
	newexe ${P} mozilla-launcher || die
}

pkg_postinst() {
	local f

	find ${ROOT}/usr/bin -maxdepth 1 -type l | \
	while read f; do
		[[ $(readlink ${f}) == mozilla-launcher ]] || continue
		einfo "Updating ${f} symlink to /usr/libexec/mozilla-launcher"
		ln -sfn /usr/libexec/mozilla-launcher ${f}
	done
}
