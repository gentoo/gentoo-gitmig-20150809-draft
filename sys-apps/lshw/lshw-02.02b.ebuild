# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lshw/lshw-02.02b.ebuild,v 1.1 2005/01/21 16:34:48 matsuu Exp $

inherit flag-o-matic eutils toolchain-funcs

MAJ_PV=${PV:0:5}
MIN_PVE=${PV:5:7}
MIN_PV=${MIN_PVE/b/B}

MY_P="$PN-$MIN_PV.$MAJ_PV"
DESCRIPTION="Hardware Lister"
HOMEPAGE="http://ezix.sourceforge.net/"
SRC_URI="mirror://sourceforge/ezix/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gtk"

DEPEND="virtual/libc
	gtk? ( >=x11-libs/gtk+-2 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/^CXXFLAGS/s/-Os/${CXXFLAGS}/" \
		-e '/^CXX=/d' -e '/^CC=/d' \
		src/{gui/,core/,}/Makefile \
		|| die "sed failed"

	#epatch ${FILESDIR}/${PV}-dev.patch #75168
	epatch ${FILESDIR}/02.00b-cpuid-PIC.patch #61947

	# cpuid.cc uses inline asm and can not be linked when
	# position independent code is desired.
	filter-flags -fPIC
}

src_compile() {
	tc-export CC CXX AR
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

	dodoc README TODO docs/*
}
