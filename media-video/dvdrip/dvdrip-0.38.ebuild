# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdrip/dvdrip-0.38.ebuild,v 1.2 2002/07/11 06:30:42 drobbins Exp $

MY_P=${P/dvdr/Video-DVDR}
S=${WORKDIR}/${MY_P}
DESCRIPTION="dvd::rip is a graphical frontend for transcode"
SRC_URI="http://www.exit1.org/dvdrip/dist/$MY_P.tar.gz"
HOMEPAGE="http://www.exit1.org/dvdrip/"

DEPEND=">=media-video/transcode-0.6.0_pre4-r1
	media-gfx/imagemagick
	gnome-extra/gtkhtml
	dev-perl/gtk-perl
	dev-perl/Storable
	dev-perl/Event"

src_compile() {
	perl Makefile.PL
	emake || die
}

src_install () {
	make PREFIX=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		install || die
	dodoc Changes MANIFEST README TODO
	cp -a ${S}/contrib ${D}/usr/share/doc/${P}
}
