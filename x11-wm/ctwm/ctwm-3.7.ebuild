# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ctwm/ctwm-3.7.ebuild,v 1.3 2006/02/11 11:39:54 nelchael Exp $

inherit eutils

IUSE=""

MY_P="${P/_/-}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A clean, light window manager."
SRC_URI="http://ctwm.free.lp.se/dist/${MY_P}.tar.gz"
#SRC_URI="http://ctwm.free.lp.se/preview/${MY_P}.tar.gz"
HOMEPAGE="http://ctwm.free.lp.se/"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="MIT"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto
		app-text/rman
		x11-misc/imake )
	virtual/x11 )
	media-libs/jpeg"

src_compile() {
	sed -i -e "s@\(CONFDIR =\).*@\1 /etc/X11/twm@g" Imakefile || die
	cp Imakefile.local-template Imakefile.local || die
	xmkmf || die
	make TWMDIR=/usr/share/${PN} || die
}

src_install() {
	make BINDIR=/usr/bin \
		 MANPATH=/usr/share/man \
		 TWMDIR=/usr/share/${PN} \
		 DESTDIR=${D} install || die

	make MANPATH=/usr/share/man \
		DOCHTMLDIR=/usr/share/doc/${PF}/html \
		DESTDIR=${D} install.man || die

	echo "#!/bin/sh" > ${T}/ctwm
	echo "/usr/bin/ctwm" >> ${T}/ctwm

	exeinto /etc/X11/Sessions
	doexe ${T}/ctwm

	dodoc CHANGES README* TODO* PROBLEMS
	dodoc *.ctwmrc*
}
