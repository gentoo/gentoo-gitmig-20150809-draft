# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xlhtml/xlhtml-0.5.ebuild,v 1.10 2005/04/02 08:47:07 blubb Exp $

inherit gnuconfig

DESCRIPTION="Convert MS Excel and Powerpoint files to HTML"
HOMEPAGE="http://chicago.sourceforge.net/xlhtml/"
SRC_URI="mirror://sourceforge/chicago/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha x86 ppc ~sparc ~amd64"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}; gnuconfig_update config.sub config.guess

	# This is needed specifically for depcomp, which is necessary for
	# building xlhtml, but isn't included.
	cd ${S}; aclocal; autoconf
	cd ${S}; automake --add-missing
}

src_compile() {
	econf || die "econf failed for ${P}"
	emake || die "emake failed for ${P}"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed for ${P}"
	dodoc AUTHORS COPYING INSTALL README
	docinto cole
	dodoc cole/{AUTHORS,COPYING,NEWS,ChangeLog,THANKS,TODO}
	docinto ppthtml
	dodoc ppthtml/{ChangeLog,README,THANKS}
	docinto xlhtml
	dodoc xlhtml/{ChangeLog,README,THANKS,TODO}
	rm -rf xlhtml/contrib/CVS
	cp -ra xlhtml/contrib ${D}/usr/share/doc/${PF}/xlhtml
}
