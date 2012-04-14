# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lshw/lshw-02.16b-r1.ebuild,v 1.2 2012/04/14 07:45:11 zmedico Exp $

EAPI=4
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
KEYWORDS="~amd64 ~amd64-linux ~x86-linux"
IUSE="gtk sqlite static"

REQUIRED_USE="static? ( !gtk )"

RDEPEND="gtk? ( x11-libs/gtk+:2 )
	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )
	sqlite? ( dev-util/pkgconfig )"
RDEPEND+=" sys-apps/hwids"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-build-v2.patch
}

src_compile() {
	tc-export CC CXX AR
	use static && append-ldflags -static

	local sqlite=$(usex sqlite 1 0)

	emake SQLITE=$sqlite all
	if use gtk ; then
		emake SQLITE=$sqlite gui
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	dodoc README docs/*
	if use gtk ; then
		emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install-gui
		make_desktop_entry /usr/sbin/gtk-lshw "Hardware Lister" "/usr/share/lshw/artwork/logo.svg"
	fi
}
