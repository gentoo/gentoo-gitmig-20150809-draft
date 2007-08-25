# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/live/live-2007.02.20.ebuild,v 1.10 2007/08/25 14:17:21 vapier Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Source-code libraries for standards-based RTP/RTCP/RTSP multimedia streaming, suitable for embedded and/or low-cost streaming applications"
HOMEPAGE="http://www.live555.com/"
SRC_URI="http://www.live555.com/liveMedia/public/${P/-/.}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"

	cp -pPR live live-shared
	mv live live-static

	cp "${FILESDIR}/config.gentoo" live-static
	cp "${FILESDIR}/config.gentoo-so" live-shared
}

src_compile() {
	tc-export CC CXX LD

	cd "${WORKDIR}/live-static"

	einfo "Beginning static library build"
	./genMakefiles gentoo
	emake -j1 || die

	cd "${WORKDIR}/live-shared"
	einfo "Beginning shared library build"
	./genMakefiles gentoo-so
	emake -j1 || die
}

src_install() {
	for library in UsageEnvironment liveMedia BasicUsageEnvironment groupsock; do
		dolib.a live-static/${library}/lib${library}.a
		dolib.so live-shared/${library}/lib${library}.so

		insinto /usr/include/${library}
		doins live-shared/${library}/include/*h
	done

	# Should we really install these?
	find live-static/testProgs -type f -perm +111 -print0 | \
		xargs -0 dobin

	#install included live555MediaServer aplication
	dobin live-static/mediaServer/live555MediaServer

	# install docs
	dodoc live-static/README
}
