# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.2.2-r3.ebuild,v 1.8 2009/05/10 07:38:42 ssuominen Exp $

EAPI=2
inherit eutils flag-o-matic eutils

DESCRIPTION="Burn CDs in disk-at-once mode -- with optional GUI frontend"
HOMEPAGE="http://cdrdao.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdrdao/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="gcdmaster debug encode pccts"

RDEPEND="virtual/cdrtools
	encode? ( >=media-sound/lame-3.90 )
	gcdmaster? ( >=dev-cpp/gtkmm-2.4
		>=dev-cpp/libgnomemm-2.6
		>=dev-cpp/libgnomecanvasmm-2.6
		>=dev-cpp/gconfmm-2.6
		>=dev-cpp/libgnomeuimm-2.6
		media-libs/libao )"
DEPEND="${RDEPEND}
	pccts? ( >=dev-util/pccts-1.33.24-r1 )
	!app-cdr/cue2toc"

pkg_setup() {
	if hasq distcc ${FEATURES}; then
		die "Please emerge without distcc in FEATURES, see bug #264170."
	fi
}

src_prepare() {
	# Use O_EXCL to avoid conflict with HAL, bug 193603.
	epatch "${FILESDIR}"/${PN}-1.2.2-excl.patch

	# fixes bug #212530
	epatch "${FILESDIR}"/${PN}-1.2.2-use-new-sigc++-API.patch

	# FreeBSD needs this patch
	# I think the correct define should be linux, but this will maintain
	# the status quo for the time being.
	# Upstream bug #1596097
	epatch "${FILESDIR}"/${PN}-1.2.2-nonlinux.patch

	# GCC 4.3 patch.  Should be fixed in next version.
	epatch "${FILESDIR}"/${PN}-1.2.2-gcc43.patch

	# Fix ERROR: CD/cdda.toc:36: Invalid CD-TEXT item for a track.
	# Bug 238891
	epatch "${FILESDIR}"/${PN}-1.2.2-toc2cue.patch

	# Fix cdrdao: Track.cc:1415: void Track::addCdTextItem(CdTextItem*): Assertion
	# `CdTextItem::isTrackPack(item->packType())' failed.
	# Bug 238891
	epatch "${FILESDIR}"/${PN}-1.2.2-cdtext.patch

	# Let default device be /dev/cdrw
	# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=452123
	epatch "${FILESDIR}"/${PN}-1.2.2-device.patch

	# Undo upstream removal of automatic reading of the track lengths in TOC
	# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=440419
	epatch "${FILESDIR}"/${PN}-1.2.2-tocparser.patch

	# Display better SCSI messages (advise from Bug 43003)
	cd scsilib/include
	sed -i -e 's:HAVE_SCANSTACK:NO_FRIGGING_SCANSTACK:g' xmconfig.h
	sed -i -e 's:HAVE_SCANSTACK:NO_FRIGGING_SCANSTACK:g' mconfig.h
}

src_configure() {
	# A few CFLAGS do not work see bug #99998
	strip-flags
	append-flags "-fno-inline"

	econf \
		$(use_enable debug)			\
		$(use_with gcdmaster xdao)		\
		$(use_with encode lame)			\
		$(use_with pccts pcctsbin /usr/bin) \
		$(use_with pccts pcctsinc /usr/include/pccts) \
		--disable-dependency-tracking || die "configure failed"
}

src_compile() {
	emake -j1 || die "could not compile"
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc AUTHORS CREDITS ChangeLog NEWS README*
}
