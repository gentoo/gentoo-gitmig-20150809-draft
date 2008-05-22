# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/live/live-2008.05.12.ebuild,v 1.1 2008/05/22 15:34:59 aballier Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Source-code libraries for standards-based RTP/RTCP/RTSP multimedia streaming, suitable for embedded and/or low-cost streaming applications"
HOMEPAGE="http://www.live555.com/"
SRC_URI="http://www.live555.com/liveMedia/public/${P/-/.}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

S="${WORKDIR}"

# Alexis Ballier <aballier@gentoo.org>
# Be careful, bump this everytime you bump the package and the ABI has changed.
# If you don't know, ask someone.
LIVE_ABI_VERSION=1

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
	emake -j1 LINK_OPTS="-L. $(raw-ldflags)" TESTPROGS_APP="" MEDIA_SERVER_APP="" || die "failed to build static libraries"

	einfo "Beginning programs build"
	cd "${WORKDIR}/live-static/testProgs"
	emake LINK_OPTS="-L. ${LDFLAGS}" || die "failed to build test programs"
	cd "${WORKDIR}/live-static/mediaServer"
	emake LINK_OPTS="-L. ${LDFLAGS}" || die "failed to build the mediaserver"

	cd "${WORKDIR}/live-shared"
	einfo "Beginning shared library build"
	./genMakefiles gentoo-so
	emake -j1 LINK_OPTS="-L. ${LDFLAGS}" LIB_SUFFIX="so.${LIVE_ABI_VERSION}" TESTPROGS_APP="" MEDIA_SERVER_APP="" || die "failed to build shared libraries"
}

src_install() {
	for library in UsageEnvironment liveMedia BasicUsageEnvironment groupsock; do
		dolib.a live-static/${library}/lib${library}.a
		dolib.so live-shared/${library}/lib${library}.so.${LIVE_ABI_VERSION}
		dosym lib${library}.so.${LIVE_ABI_VERSION} /usr/$(get_libdir)/lib${library}.so

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

pkg_postinst() {
	ewarn "If you are upgrading from a version prior to live-2008.02.08"
	ewarn "Please make sure to rebuild applications built against ${PN}"
	ewarn "like vlc or mplayer. ${PN} may have had ABI changes and ${PN}"
	ewarn "support might be broken."
}
