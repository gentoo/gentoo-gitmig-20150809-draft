# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.9-r5.ebuild,v 1.2 2002/07/16 03:42:04 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz
	http://fluxbox.sourceforge.net/download/patches/${P}-bugfix2.patch
	truetype? ( http://www.oberdorf.org/oly/Computers/OlyWare/FluxBoxAA/${P}-oly-allinone.patch.bz2 )"

HOMEPAGE="http://fluxbox.sf.net"

DEPEND="virtual/x11"
	
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/blackbox"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	patch -p1 <  ${DISTDIR}/${P}-bugfix2.patch || die

	use truetype && \
		bzcat ${DISTDIR}/${P}-oly-allinone.patch.bz2 | patch -p1 || die

	cd src
	patch < ${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	local myconf
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use kde \
		&& myconf="${myconf} --enable-kde" \
		&& export KDEDIR=/usr/kde/2 \
		|| myconf="${myconf} --disable-kde"

	use gnome \
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome"

	use truetype \
		&& myconf="${myconf} --enable-antialiasing" \
		|| myconf="${myconf} --disable-antialiasing"

	econf ${myconf} --enable-xinerama || die

	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/X11/fluxbox \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share \
		install || die

	dodoc ChangeLog AUTHORS COPYING INSTALL README TODO NEWS
	docinto data
	dodoc data/README*

	dodir /etc/X11/Sessions
	echo "/usr/bin/fluxbox" > ${D}/etc/X11/Sessions/fluxbox
	fperm +x /etc/X11/Sessions/fluxbox
}


pkg_postinst() {

	if [ "`use truetype`" ]
	then
		einfo "To actually enable anti-aliasing in fluxbox, you must call"
		einfo "it using: fluxbox -antialias"
	fi
}
