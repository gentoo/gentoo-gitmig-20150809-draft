# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion2/ion2-20040211-r2.ebuild,v 1.4 2004/03/31 00:30:57 twp Exp $

inherit eutils

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://modeemi.fi/~tuomov/dl/ion-2-20040207.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~mips ~ppc ~sparc x86"
IUSE="truetype xinerama"
DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5.0.1_beta20031003
	>=sys-devel/libtool-1.4.3"
S=${WORKDIR}/ion-2-20040207

src_unpack() {

	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/ion2-20040207-20040211.patch

	if [ `use truetype` ]; then
		mkdir xftde
		cp de/{*.c,*.h,Makefile} xftde
		( cd xftde && epatch ${FILESDIR}/xftde-20040207.patch )
		sed -i modulelist.mk \
			-e 's/^\(MODULE_LIST =\)/\1 xftde/g'
	fi

}

src_compile() {

	local myconf=""

	if has_version '>=x11-base/xfree-4.3.0'; then
		myconf="${myconf} --disable-xfree86-textprop-bug-workaround"
	fi

	econf \
		--sysconfdir=/etc/X11 \
		`use_enable xinerama` \
		${myconf} || die

	emake \
		DOCDIR=/usr/share/doc/${PF} || die

}

src_install() {

	make \
		prefix=${D}/usr \
		ETCDIR=${D}/etc/X11/ion \
		SHAREDIR=${D}/usr/share/ion \
		MANDIR=${D}/usr/share/man \
		DOCDIR=${D}/usr/share/doc/${PF} \
		install || die

	prepalldocs

	insinto /usr/include/ion
	doins *.h *.mk mkexports.lua
	for i in de floatws ioncore ionws luaextl menu query; do
		insinto /usr/include/ion/${i}
		doins ${i}/*.h
	done
	insinto /usr/include/ion/libtu
	doins libtu/include/libtu/*

	echo -e "#!/bin/sh\n/usr/bin/ion" > ${T}/ion
	echo -e "#!/bin/sh\n/usr/bin/pwm" > ${T}/pwm
	exeinto /etc/X11/Sessions
	doexe ${T}/ion ${T}/pwm

	insinto /usr/share/xsessions
	doins ${FILESDIR}/ion2.desktop

}
