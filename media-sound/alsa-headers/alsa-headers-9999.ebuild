# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-headers/alsa-headers-9999.ebuild,v 1.7 2009/06/02 17:13:25 beandog Exp $

inherit eutils git

DESCRIPTION="Header files for Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="binchecks strip"

EGIT_REPO_URI="git://git.alsa-project.org/alsa-kmirror.git"
EGIT_PROJECT="alsa-kmirror"

# Remove the sound symlink workaround...
pkg_setup() {
	if [[ -L "${ROOT}/usr/include/sound" ]]; then
		rm	"${ROOT}/usr/include/sound"
	fi
}

src_unpack() {
	git_src_unpack

	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.0.6a-user.patch"
}

src_compile() { : ; }

src_install() {
	cd "${S}/include"
	insinto /usr/include/sound
	doins *.h || die "include failed"
}
