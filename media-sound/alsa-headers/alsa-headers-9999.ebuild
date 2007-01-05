# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-headers/alsa-headers-9999.ebuild,v 1.5 2007/01/05 17:19:31 flameeyes Exp $

inherit eutils mercurial

DESCRIPTION="Header files for Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND=""

RESTRICT="binchecks strip"

EHG_PROJECT="alsa-driver"

S="${WORKDIR}"

# Remove the sound symlink workaround...
pkg_setup() {
	if [[ -L "${ROOT}/usr/include/sound" ]]; then
		rm	"${ROOT}/usr/include/sound"
	fi
}

src_unpack() {
	mercurial_fetch http://hg.alsa-project.org/alsa-kernel alsa-kernel

	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.0.6a-user.patch"
}

src_compile() { :; }

src_install() {
	cd "${S}/alsa-kernel/include"
	insinto /usr/include/sound
	doins *.h || die "include failed"
}
