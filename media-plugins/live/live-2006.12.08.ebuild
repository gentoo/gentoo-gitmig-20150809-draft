# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/live/live-2006.12.08.ebuild,v 1.1 2006/12/30 20:17:33 flameeyes Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Source-code libraries for standards-based RTP/RTCP/RTSP multimedia streaming, suitable for embedded and/or low-cost streaming applications"
HOMEPAGE="http://www.live555.com/"
SRC_URI="http://www.live555.com/liveMedia/public/${P/-/.}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
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
	find live-shared/testProgs -type f -perm +111 -print0 | \
		xargs -0 dobin

	# install docs
	dodoc README
}
