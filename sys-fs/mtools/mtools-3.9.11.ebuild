# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtools/mtools-3.9.11.ebuild,v 1.6 2009/11/26 13:41:23 josejx Exp $

inherit eutils

DESCRIPTION="utilities to access MS-DOS disks from Unix without mounting them"
HOMEPAGE="http://mtools.linux.lu/"
SRC_URI="http://mtools.linux.lu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ppc ppc64 ~sparc x86"
IUSE="X"

DEPEND="
	X? (
		x11-libs/libICE
		x11-libs/libXau
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXt
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-flags.patch #232766
	sed -i 's:/usr/local/etc:/etc:g' mtools.5 mtools.texi
}

src_compile() {
	econf \
		--sysconfdir=/etc/mtools \
		$(use_with X x) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	insinto /etc/mtools
	doins mtools.conf || die
	dosed '/^SAMPLE FILE$/s:^:#:' /etc/mtools/mtools.conf # default is fine
	dodoc Changelog README* Release.notes
}
