# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.2.3_rc2.ebuild,v 1.2 2009/05/22 20:50:01 loki_val Exp $

EAPI=2
inherit eutils flag-o-matic eutils autotools

DESCRIPTION="Burn CDs in disk-at-once mode -- with optional GUI frontend"
HOMEPAGE="http://cdrdao.sourceforge.net/"
if [[ ${PV/*_rc*} ]]
then
	SRC_URI="mirror://sourceforge/cdrdao/${P}.tar.bz2"
else
	SRC_URI="http://www.poolshark.org/src/${P/_}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="gcdmaster encode pccts mp3 ogg"

RDEPEND="virtual/cdrtools
	encode? ( >=media-sound/lame-3.90 )
	gcdmaster? ( >=dev-cpp/gtkmm-2.4
		>=dev-cpp/libgnomemm-2.6
		>=dev-cpp/libgnomecanvasmm-2.6
		>=dev-cpp/gconfmm-2.6
		>=dev-cpp/libgnomeuimm-2.6
		media-libs/libao
	)
	mp3? (
		media-libs/libmad
		media-libs/libao
	)
	ogg? (
		media-libs/libvorbis
		media-libs/libao
	)
	"
DEPEND="${RDEPEND}
	pccts? ( >=dev-util/pccts-1.33.24-r1 )
	!app-cdr/cue2toc"

S="${WORKDIR}/${P/_}"

pkg_setup() {
	if hasq distcc ${FEATURES}; then
		die "Please emerge without distcc in FEATURES, see bug #264170."
	fi
}

src_prepare() {
	# Fix ERROR: CD/cdda.toc:36: Invalid CD-TEXT item for a track.
	# Bug 238891
	epatch "${FILESDIR}"/${PN}-1.2.3-toc2cue.patch

	# Undo upstream removal of automatic reading of the track lengths in TOC
	# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=440419
	epatch "${FILESDIR}"/${PN}-1.2.3-tocparser.patch

	epatch "${FILESDIR}"/${PN}-1.2.3-gcc44.patch
	epatch "${FILESDIR}"/${PN}-1.2.3-pkg-config.patch
	epatch "${FILESDIR}"/${PN}-1.2.3-autoconf-update.patch

	epatch "${FILESDIR}"/${PN}-1.2.3-k3b.patch
	eautoreconf
}

src_configure() {
	# A few CFLAGS do not work see bug #99998
	#strip-flags
	#append-flags "-fno-inline"

	econf \
		$(use_with gcdmaster xdao)		\
		$(use_with encode lame)			\
		$(use_with mp3 mp3-support)		\
		$(use_with ogg ogg-support)		\
		--disable-dependency-tracking || die "configure failed"
}

src_compile() {
	emake -j1 || die "could not compile"
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc AUTHORS CREDITS ChangeLog NEWS README*
}
