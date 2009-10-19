# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.2.3_rc2.ebuild,v 1.13 2009/10/19 16:23:56 armin76 Exp $

EAPI=2
inherit autotools eutils toolchain-funcs

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
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="gcdmaster encode pccts mad vorbis"

RDEPEND="virtual/cdrtools
	encode? ( >=media-sound/lame-3.90 )
	gcdmaster? ( >=dev-cpp/gtkmm-2.4
		>=dev-cpp/libgnomemm-2.6
		>=dev-cpp/libgnomecanvasmm-2.6
		>=dev-cpp/gconfmm-2.6
		>=dev-cpp/libgnomeuimm-2.6
		media-libs/libao )
	mad? ( media-libs/libmad
		media-libs/libao )
	vorbis? ( media-libs/libvorbis
		media-libs/libao )"
DEPEND="${RDEPEND}
	pccts? ( >=dev-util/pccts-1.33.24-r1 )
	!app-cdr/cue2toc"

MAKEOPTS="${MAKEOPTS} -j1"
S=${WORKDIR}/${P/_}

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
	local myconf

	econf \
		$(use_with gcdmaster xdao) \
		$(use_with encode lame) \
		$(use_with mad mp3-support) \
		$(use_with vorbis ogg-support) \
		--disable-dependency-tracking \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS README*
}
