# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.2.10.6.ebuild,v 1.1 2009/06/21 07:31:59 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="http://packages.debian.org/mpg321"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa -mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="+symlink"

RDEPEND="sys-libs/zlib
	media-libs/libmad
	media-libs/libid3tag
	media-libs/libao
	!<media-sound/mpg321-0.2.10-r4
	symlink? ( !media-sound/mpg123 )"
DEPEND="${RDEPEND}"
PDEPEND="symlink? ( virtual/mpg123 )"

pkg_setup() {
	local link="${ROOT}usr/bin/mpg123"
	local msg="Removing invalid symlink ${link}"
	if use symlink; then
		if [ -L "${link}" ]; then
			ebegin "${msg}"
			rm -f "${link}" || die "${msg} failed, please open a bug."
			eend $?
		fi
	fi
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable symlink mpg123-symlink)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newdoc debian/changelog ChangeLog.debian
	dodoc AUTHORS BUGS HACKING NEWS README{,.remote} THANKS TODO
}
