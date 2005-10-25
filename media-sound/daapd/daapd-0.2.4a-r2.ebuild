# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/daapd/daapd-0.2.4a-r2.ebuild,v 1.1 2005/10/25 05:26:32 flameeyes Exp $

inherit flag-o-matic eutils

DESCRIPTION="daapd scans a directory for mp3 files and makes them available via the Apple proprietary protocol DAAP"
HOMEPAGE="http://www.deleet.de/projekte/daap/daapd/"
SRC_URI="http://www.deleet.de/projekte/daap/daapd/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc"
IUSE="aac howl mpeg4"

DEPEND="sys-libs/zlib
	howl? ( >=net-misc/howl-0.9.6-r1 )
	aac? ( media-libs/faad2 )
	>=media-libs/libid3tag-0.15.0b
	>=net-libs/libhttpd-persistent-1.3p-r8
	>=media-libs/daaplib-0.1.1a"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PN}-0.2.4-gentoo.patch"
	epatch "${FILESDIR}/${P}-defaults.patch"
}

src_compile() {
	local want_howl want_mpeg4
	use howl && want_howl="1" || want_howl="0"
	use mpeg4 && want_mpeg4="1" || want_mpeg4="0"

	# The makefile is dumb, uses $(CC) to compile .cc files
	# pass it a C++ compiler and C++ flags
	emake \
		CC=$(tc-getCXX) OPTFLAGS="${CXXFLAGS}" \
		HOWL_ENABLE="$want_howl" MPEG4_ENABLE="$want_mpeg4" \
		|| die "make failed"

	# Make sure that it requires mDNSResponder while using howl
	cp ${FILESDIR}/daapd.init.d-2 ${WORKDIR}/daapd.init.d
	use howl && \
		sed -i -e 's:#WITHHOWL ::' ${WORKDIR}/daapd.init.d || \
		sed -i -e '/#WITHHOWL/d' ${WORKDIR}/daapd.init.d
}

src_install() {
	dobin daapd

	dodoc README* daapd-example.conf
	doman ${PN}.8

	insinto /etc
	newins daapd-example.conf daapd.conf

	newconfd ${FILESDIR}/daapd.conf.d daapd || die
	newinitd ${WORKDIR}/daapd.init.d daapd || die
}

