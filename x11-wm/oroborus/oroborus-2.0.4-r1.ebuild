# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus/oroborus-2.0.4-r1.ebuild,v 1.5 2002/08/01 11:40:17 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Yet another window manager"
SRC_URI="http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/${P}.tar.gz"
HOMEPAGE="http://www.kensden.pwp.blueyonder.co.uk/Oroborus"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"


src_compile() {

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc/X11/oroborus			\
	 	    --infodir=/usr/share/info				\
		    --mandir=/usr/share/man				\
		    || die
	
	emake || die
}

src_install () {

	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc/X11/oroborus				\
	     infodir=${D}/usr/share/info				\
	     mandir=${D}/usr/share/man					\
	     install || die

	if [ "`use gnome`" ] ; then

		insinto /usr/share/gnome/wm-properties
		doins ${FILESDIR}/oroborus.desktop
	fi

	dodoc README INSTALL ChangeLog TODO NEWS AUTHORS example.oroborusrc
}

