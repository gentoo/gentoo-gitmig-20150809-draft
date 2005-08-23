# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/afterstep/afterstep-1.8.11-r2.ebuild,v 1.23 2005/08/23 18:55:31 ka0ttic Exp $

S=${WORKDIR}/AfterStep-${PV}
DESCRIPTION="A window manager based on the NeXTStep interface."
SRC_URI="ftp://ftp.afterstep.org/stable/AfterStep-${PV}.tar.bz2"
HOMEPAGE="http://www.afterstep.org/"
LICENSE="AFTERSTEP"
SLOT="0"
KEYWORDS="x86 sparc ppc ~mips"
IUSE="nls"

DEPEND="virtual/libc virtual/x11
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1"
## >=media-libs/xpm-3.4k

RDEPEND="${DEPEND}
	 >=media-sound/sox-12.17.1"


src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	local myconf
	use nls && myconf="${myconf} --enable-i18n"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--libdir=/usr/lib \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc/X11 \
		--with-helpcommand="xterm -e man" \
		--disable-availability \
		--disable-staticlibs \
		--with-xpm \
		${myconf} || die

	emake || die
}

src_install() {

	make DESTDIR=${D} \
	     GNUSTEP_LOCAL_ROOT=${D}${GNUSTEP_LOCAL_ROOT} \
	     install || die

	rm -f ${D}/usr/bin/sessreg

	dodoc COPYRIGHT ChangeLog INSTALL NEW README* TEAM UPGRADE
	cp -pPR ${S}/TODO ${D}/usr/share/doc/${PF}/
	dodir /usr/share/doc/${PF}/html
	cp -pPR ${S}/doc/* ${D}/usr/share/doc/${PF}/html
	rm ${D}/usr/share/doc/${PF}/html/Makefile*

	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/afterstep

}
