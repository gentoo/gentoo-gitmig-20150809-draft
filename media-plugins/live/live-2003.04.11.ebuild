# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/live/live-2003.04.11.ebuild,v 1.1 2003/04/12 15:35:08 hannes Exp $

DESCRIPTION="Source-code libraries for standards-based RTP/RTCP/RTSP multimedia streaming, suitable for embedded and/or low-cost streaming applications"

HOMEPAGE="http://www.live.com/"
MY_P=${P/-/.}
SRC_URI="http://www.live.com/liveMedia/public/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i.orig -e "s:-O:${CFLAGS} -Wno-deprecated:" config.linux
}

src_compile() {
	./genMakefiles linux
	# emake doesn't work
	make || die
}

src_install() {
	# no installer, go manual ...

	# find and install libraries, mplayer needs to find
	# each library in a subdirectory with same name as
	# the lib

	local lib
	for lib in $(find ${S} -type f -name \*.a)
	do
		local dir
		dir=$(basename $(dirname ${lib}))

		insinto "/usr/lib/live/${dir}"
		doins "${lib}"

		insinto "/usr/lib/live/${dir}/include"
		doins ${S}/${dir}/include/*h
	done

	# find and install test programs
	exeinto /usr/bin
	find ${S}/testProgs -type f -perm +111 -exec doexe {} \;

	dodoc ${S}/README
}
