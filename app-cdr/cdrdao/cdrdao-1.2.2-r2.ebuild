# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.2.2-r2.ebuild,v 1.14 2008/12/05 13:23:15 ssuominen Exp $

inherit eutils flag-o-matic eutils

DESCRIPTION="Burn CDs in disk-at-once mode -- with optional GUI frontend"
HOMEPAGE="http://cdrdao.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdrdao/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="gcdmaster debug encode pccts"

RESTRICT="strip"

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

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Use O_EXCL to avoid conflict with HAL, bug 193603.
	epatch "${FILESDIR}"/${P}-excl.patch

	# fixes bug #212530
	epatch "${FILESDIR}"/${PN}-1.2.2-use-new-sigc++-API.patch

	# FreeBSD needs this patch
	# I think the correct define should be linux, but this will maintain
	# the status quo for the time being.
	# Upstream bug #1596097
	epatch "${FILESDIR}"/${P}-nonlinux.patch

	# GCC 4.3 patch.  Should be fixed in next version.
	epatch "${FILESDIR}"/${P}-gcc43.patch

	# Display better SCSI messages (advise from Bug 43003)
	cd scsilib/include
	sed -i -e 's:HAVE_SCANSTACK:NO_FRIGGING_SCANSTACK:g' xmconfig.h
	sed -i -e 's:HAVE_SCANSTACK:NO_FRIGGING_SCANSTACK:g' mconfig.h
}

src_compile() {
	# A few CFLAGS do not work see bug #99998
	strip-flags
	append-flags "-fno-inline"

	econf \
		$(use_enable debug) \
		$(use_with gcdmaster xdao) \
		$(use_with encode lame) \
		$(use_with pccts pcctsbin /usr/bin) \
		$(use_with pccts pcctsinc /usr/include/pccts) \
		--disable-dependency-tracking || die "configure failed"

	make || die "could not compile"
}

src_install() {
	einstall || die "could not install"

	cd "${S}"

	dodoc AUTHORS CREDITS ChangeLog NEWS README*
}
