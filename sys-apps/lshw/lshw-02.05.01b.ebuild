# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lshw/lshw-02.05.01b.ebuild,v 1.1 2005/07/22 04:17:51 vapier Exp $

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
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gtk static"

DEPEND="gtk? ( >=x11-libs/gtk+-2 )
	>=sys-devel/binutils-2.15"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	use static && append-ldflags -static
	sed -i \
		-e "/^CXXFLAGS/s:-Os:${CXXFLAGS}:" \
		-e '/^LDFLAGS=/s:-Os -s::' \
		-e '/^CXX=/d' -e '/^CC=/d' \
		src/{gui/,core/,}/Makefile \
		|| die "sed failed"
	sed -i \
		-e "/^LDFLAGS=/s:$: ${LDFLAGS}:" \
		src/Makefile || die "sed ldflags failed"

	epatch "${FILESDIR}"/02.00b-cpuid-PIC.patch #61947
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

	dodoc README docs/*
}
