# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/showeq/showeq-4.3.18.ebuild,v 1.5 2004/03/30 07:58:45 mr_bones_ Exp $

inherit games

S="${WORKDIR}/${PN}"
DESCRIPTION="A Everquest monitoring program"
HOMEPAGE="http://seq.sourceforge.net"
SRC_URI="mirror://sourceforge/seq/ShowEQ-${PV}.tar.bz2"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="virtual/x11
	media-libs/libpng
	>=net-libs/libpcap-0.6.2
	>=x11-libs/qt-3.0.5
	>=sys-libs/gdbm-1.8.0"
DEPEND="${RDEPEND}
	sys-devel/libtool
	sys-devel/autoconf
	sys-devel/automake
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/CFLAGS/s:-O2:${CFLAGS}:" \
		-e "/CXXFLAGS/s:-O2:${CXXFLAGS}:" acinclude.m4 || \
			die "sed acinclude.m4 failed"
	sed -i \
		-e "/OPT_CXX=/s:-O2:${CXXFLAGS}:" \
		-e "/OPT_C=/s:-O2:${CFLAGS}:" configure.in || \
			die "sed configure.in failed"
}

src_compile() {
	cd ${S}
	make -f Makefile.dist || die "make failed"
	egamesconf            || die
	emake                 || die "emake failed"
}

src_install() {
	egamesinstall  || die
	doman showeq.1 || die "doman failed"
	dodoc BUGS CHANGES FAQ INSTALL README* ROADMAP TODO doc/*.{doc,txt} || \
				      die "dodoc failed"
	dohtml doc/*   || die "dohtml failed"
	prepgamesdirs
}
