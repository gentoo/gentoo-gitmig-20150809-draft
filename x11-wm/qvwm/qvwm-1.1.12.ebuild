# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/qvwm/qvwm-1.1.12.ebuild,v 1.3 2004/01/23 15:23:30 usata Exp $

DESCRIPTION="Qvwm is a Windows 9X like window manager for X Window System."
HOMEPAGE="http://www.qvwm.org/"
SRC_URI="http://www.qvwm.org/archive/qvwm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="imlib esd"

RDEPEND="virtual/x11
	imlib? ( >=media-libs/imlib-1.8.2 )
	esd? ( >=media-sound/esound-0.2.6 )"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

S=${WORKDIR}/${P}

src_compile(){

	econf \
		`use_with imlib` \
		`use_with esd` || die
	emake || die
}

src_install(){
	make DESTDIR=${D} install || die

	dodoc doc/*
	insinto /etc/skel
	newins rc/system.qvwmrc .qvwmrc

	exeinto /etc/X11/Sessions
	echo "#!/bin/bash" > qvwm
	echo "/usr/bin/qvwm" >> qvwm
	doexe qvwm
}
