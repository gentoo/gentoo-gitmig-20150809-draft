# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

S=${WORKDIR}/AfterStep-${PV}
DESCRIPTION="A window manager based on the NeXTStep interface."
SRC_URI="ftp://ftp.afterstep.org/stable/AfterStep-${PV}.tar.bz2"
HOMEPAGE="http://www.afterstep.org/"
LICENSE="AFTERSTEP"
SLOT="0"
KEYWORDS="x86 sparc "
IUSE="nls"

DEPEND="virtual/glibc virtual/x11
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	x11-wm/gnustep-env"

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

	econf \
		--libdir=/usr/lib \
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
	cp -a ${S}/TODO ${D}/usr/share/doc/${PF}/
	dodir /usr/share/doc/${PF}/html
	cp -a ${S}/doc/* ${D}/usr/share/doc/${PF}/html
	rm ${D}/usr/share/doc/${PF}/html/Makefile*
	
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/afterstep
}
