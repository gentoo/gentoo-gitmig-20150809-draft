# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.2.1-r1.ebuild,v 1.8 2006/07/06 01:32:20 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="Burn CDs in disk-at-once mode -- with optional GUI frontend"
HOMEPAGE="http://cdrdao.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdrdao/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 sh ~sparc x86"
IUSE="gnome debug encode pccts"
RESTRICT="strip"

RDEPEND="encode? ( >=media-sound/lame-3.90 )
	gnome? ( >=dev-cpp/gtkmm-2.4
		>=dev-cpp/libgnomemm-2.6
		>=dev-cpp/libgnomecanvasmm-2.6
		>=dev-cpp/gconfmm-2.6
		>=dev-cpp/libgnomeuimm-2.6
		media-libs/libao )"
DEPEND="pccts? ( >=dev-util/pccts-1.33.24-r1 )
	virtual/cdrtools
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc41.patch

	# Display better SCSI messages (advise from Bug 43003)
	cd scsilib/include
	sed -i -e 's:HAVE_SCANSTACK:NO_FRIGGING_SCANSTACK:g' xmconfig.h
	sed -i -e 's:HAVE_SCANSTACK:NO_FRIGGING_SCANSTACK:g' mconfig.h

	cd "${S}"/scsilib/RULES
	cp x86_64-linux-cc.rul sh4-linux-cc.rul
}

src_compile() {
	# A few CFLAGS do not work see bug #99998
	strip-flags
	append-flags "-fno-inline"

	econf \
		$(use_enable debug) \
		$(use_with gnome xdao) \
		$(use_with encode lame) \
		$(use_with pccts pcctsbin /usr/bin) \
		$(use_with pccts pcctsinc /usr/include/pccts) \
		--disable-dependency-tracking || die "configure failed"

	make || die "could not compile"
}

src_install() {
	einstall || die "could not install"
	dodoc AUTHORS CREDITS ChangeLog NEWS README*
}
