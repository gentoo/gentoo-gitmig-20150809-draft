# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtools/mtools-3.9.11.ebuild,v 1.1 2008/08/17 17:26:53 vapier Exp $

inherit eutils

DESCRIPTION="utilities to access MS-DOS disks from Unix without mounting them"
HOMEPAGE="http://mtools.linux.lu/"
SRC_URI="http://mtools.linux.lu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
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
}

src_compile() {
	econf \
		--sysconfdir=/etc/mtools \
		$(use_with X x) \
		|| die
	emake || die "emake failed"
}

src_install() {
	einstall sysconfdir="${D}"/etc/mtools || die
	insinto /etc/mtools
	doins mtools.conf || die
	dodoc Changelog README* Release.notes
}
