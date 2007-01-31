# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtools/mtools-3.9.10.ebuild,v 1.9 2007/01/31 04:48:02 vapier Exp $

DESCRIPTION="utilities to access MS-DOS disks from Unix without mounting them"
HOMEPAGE="http://mtools.linux.lu/"
SRC_URI="http://mtools.linux.lu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc x86"
IUSE="X"

DEPEND="X? ( x11-libs/libICE
	x11-libs/libXau
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXt )"

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
	newins mtools.conf mtools.conf.example
	dodoc Changelog README* Release.notes
}
