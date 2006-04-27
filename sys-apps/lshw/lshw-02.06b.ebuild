# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lshw/lshw-02.06b.ebuild,v 1.6 2006/04/27 15:43:55 dang Exp $

inherit flag-o-matic eutils toolchain-funcs

MAJ_PV=${PV:0:${#PV}-1}
MIN_PVE=${PV:0-1}
MIN_PV=${MIN_PVE/b/B}

MY_P="$PN-$MIN_PV.$MAJ_PV"
DESCRIPTION="Hardware Lister"
HOMEPAGE="http://ezix.sourceforge.net/"
SRC_URI="http://ezix.sourceforge.net/software/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc sparc x86"
IUSE="gtk static"

DEPEND="gtk? ( >=x11-libs/gtk+-2 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-02.06b-build.patch
	epatch "${FILESDIR}"/${PN}-02.06b-cpuid-PIC.patch #61947
}

src_compile() {
	tc-export CC CXX AR
	use static && append-ldflags -static
	emake || die "make failed"
	if use gtk ; then
		emake gui || die "make gui failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	if use gtk ; then
		make DESTDIR="${D}" install-gui || die "install gui failed"
	fi

	dodoc README docs/*
}
