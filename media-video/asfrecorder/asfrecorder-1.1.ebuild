# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/asfrecorder/asfrecorder-1.1.ebuild,v 1.4 2003/12/26 19:50:06 vapier Exp $

inherit gcc

MY_PN="${PN/asfr/ASFR}"
DESCRIPTION="ASFRecorder - Download Windows Media Streaming files"
HOMEPAGE="http://sourceforge.net/projects/asfrecorder/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

S=${WORKDIR}/${MY_PN}

src_compile() {
	# There is a Makefile, but it only works for Cygwin, so we
	# only compile this single program.
	cd ${S}/source
	$(gcc-getCC) -o asfrecorder ${CFLAGS} asfrecorder.c || die "Build failed"
}

src_install () {
	# Again, no makefiles, so just take what we want.
	dobin ${S}/source/asfrecorder
	dodoc ${S}/README.TXT
}
