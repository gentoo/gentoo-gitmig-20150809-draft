# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vi/vi-3.7-r2.ebuild,v 1.8 2003/09/05 23:05:05 msterret Exp $

MY_P=ex-020403
S=${WORKDIR}/${MY_P}

DESCRIPTION="The original VI package"
SRC_URI="http://download.berlios.de/ex-vi/${MY_P}.tar.gz"
HOMEPAGE="http://ex-vi.berlios.de/"

LICENSE="Caldera"
SLOT="0"
KEYWORDS="x86 ppc sparc "

DEPEND="sys-libs/ncurses"

PROVIDE="virtual/editor"

src_compile() {
	addpredict /dev/ptys/*

	make DESTDIR=/usr \
		TERMLIB=termlib \
		PRESERVEDIR=/var/preserve \
		|| die "failed compilation"
}

src_install() {
	dodir /var/preserve /usr/share/man
	make INSTALL=/usr/bin/install \
		DESTDIR=${D}/usr \
		MANDIR=/share/man \
		PRESERVEDIR=${D}/var/preserve \
		TERMLIB=termlib \
		install || die

	dodoc Changes LICENSE README TODO
}

pkg_postinst() {

	if [ "${ROOT}" = "/" ] && [ ! -f /etc/termcap ]
	then
		ewarn "vi needs /etc/termcap, so please install the latest"
		ewarn "baselaout (if 1.8.1 is released yet), or get it from:"
		ewarn ""
		ewarn "http://www.ibiblio.org/gentoo/distfiles/termcap.bz2"
		ewarn ""
		ewarn "and install it in /etc with permissions 0644."
	fi
}

