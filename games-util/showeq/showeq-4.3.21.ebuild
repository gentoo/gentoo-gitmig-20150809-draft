# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/showeq/showeq-4.3.21.ebuild,v 1.4 2005/06/15 19:24:21 wolf31o2 Exp $

inherit games

DESCRIPTION="A Everquest monitoring program"
HOMEPAGE="http://seq.sourceforge.net/"
SRC_URI="mirror://sourceforge/seq/ShowEQ-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/x11
	media-libs/libpng
	virtual/libpcap
	>=x11-libs/qt-3.1
	>=sys-libs/gdbm-1.8.0"
DEPEND="${RDEPEND}
	sys-devel/libtool
	sys-devel/autoconf
	sys-devel/automake
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/CFLAGS/s:-O2:${CFLAGS}:" \
		-e "/CXXFLAGS/s:-O2:${CXXFLAGS}:" \
		acinclude.m4 \
		|| die "sed acinclude.m4 failed"
	sed -i \
		-e "/USE_OPT_C=/s:-O[1-9]:${CFLAGS}:" \
		-e "/USE_OPT_CXX=/s:-O[1-9]:${CXXFLAGS}:" \
		configure.in \
		|| die "sed configure.in failed"

	env \
		WANT_AUTOCONF=2.5 \
		WANT_AUTOMAKE=1.8 \
		make -f Makefile.dist no-backup || die "make dist failed"
}

src_install() {
	egamesinstall || die
	doman showeq.1
	dodoc BUGS CHANGES FAQ README* ROADMAP TODO doc/*.{doc,txt}
	dohtml doc/*
	prepgamesdirs
}
