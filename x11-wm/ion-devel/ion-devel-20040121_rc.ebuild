# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-devel/ion-devel-20040121_rc.ebuild,v 1.1 2004/01/21 15:36:37 twp Exp $

MY_P=ion-2rc-20040121
DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://modeemi.fi/~tuomov/dl/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="truetype xinerama"
DEPEND="virtual/x11
	app-misc/run-mailcap
	>=dev-lang/lua-5.0.1_beta20031003"
S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${A}

	cd ${S}

	if [ `use truetype` ]; then
		mkdir xftde
		cp de/{*.c,*.h,Makefile} xftde
		( cd xftde && epatch ${FILESDIR}/xftde-20040114_rc.patch )
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

}
