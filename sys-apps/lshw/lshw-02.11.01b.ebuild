# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lshw/lshw-02.11.01b.ebuild,v 1.3 2007/08/25 19:10:18 vapier Exp $

inherit flag-o-matic eutils toolchain-funcs

MAJ_PV=${PV:0:${#PV}-1}
MIN_PVE=${PV:0-1}
MIN_PV=${MIN_PVE/b/B}

MY_P="$PN-$MIN_PV.$MAJ_PV"
DESCRIPTION="Hardware Lister"
HOMEPAGE="http://ezix.org/project/wiki/HardwareLiSter"
SRC_URI="http://ezix.org/software/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="gtk static"
RESTRICT="strip"

DEPEND="gtk? ( >=x11-libs/gtk+-2 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-02.11.01b-build.patch
	epatch "${FILESDIR}"/${PN}-02.09b-cpuid-PIC.patch #61947
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
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README docs/*
	if use gtk ; then
		emake DESTDIR="${D}" install-gui || die "install gui failed"
		make_desktop_entry /usr/sbin/gtk-lshw "Hardware Lister" "/usr/share/lshw/artwork/logo.svg"
	fi
}
