# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blwm/blwm-1.0.4.ebuild,v 1.4 2005/08/07 13:30:06 hansmi Exp $

inherit gnuconfig

DESCRIPTION="BLWM is a Windows 2000 like window manager localized for Brazil."
HOMEPAGE="http://www.blanes.com.br"
SRC_URI="http://labdid.if.usp.br/~blanes/arquivos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="virtual/x11"

DEPEND="${RDEPEND}
	=sys-devel/autoconf-2.13*
	=sys-devel/automake-1.4*
	sys-devel/flex
	sys-devel/bison"

src_compile(){
	export WANT_AUTOCONF=2.1
	export WANT_AUTOMAKE=1.4
	aclocal || die
	autoheader || die
	autoconf || die
	# automake fails on some systems, but harmless to build
	automake

	econf --with-blwmdir=/usr/share/blwm --with-confdir=/etc/blwm || die
	emake || die
}

src_install(){
	make DESTDIR=${D} install || die

	dodoc doc/*
	insinto /etc/skel
	newins rc/system.blwmrc .blwmrc

	exeinto /etc/X11/Sessions
	echo "#!/bin/bash" > blwm
	echo "/usr/bin/blwm" >> blwm
	doexe blwm
}
