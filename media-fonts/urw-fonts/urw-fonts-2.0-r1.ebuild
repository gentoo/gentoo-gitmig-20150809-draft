# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/urw-fonts/urw-fonts-2.0-r1.ebuild,v 1.6 2004/02/09 18:03:23 absinthe Exp $

DESCRIPTION="free good quality fonts gpl'd by URW++"
HOMEPAGE=""
SRC_URI="mirror://gentoo/urw-fonts-2.0-29.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"

DEPEND="app-arch/rpm2targz"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}
	cd ${S}
	rpm2targz ${A}
	tar -xzf ${A/.rpm/.tar.gz}
	tar -xjf urw-fonts-2.0.tar.bz2
	tar -xjf urw-symbol.tar.bz2
	mv s050000l.* fonts/
	tar -xjf urw-tweaks.tar.bz2
	mv n019003l.* fonts/
	tar -xjf urw-dingbats.tar.bz2
	mv d050000l.* fonts/
	epatch urw-fonts-2.0-encodings.patch
}

src_install() {
	cd ${S}/fonts
	mkdir -p ${D}/usr/share/fonts/default/Type1
	cp -f *.afm *.pfb ${D}/usr/share/fonts/default/Type1
	cp ${S}/fonts/fonts.scale ${D}/usr/share/fonts/default/Type1/
	mkdir -p ${D}/etc/fonts
	# Don't add this, it makes no changes not already needed in fonts.conf
	# Brad Laue <brad@gentoo.org> 08/07/2003
#	cp ${FILESDIR}/fonts.conf ${D}/etc/fonts/
}

pkg_postinst() {
	# this just doesn't work here...i'm going to see if i can make it work later
	# cat ${S}/fonts/fonts.scale >> /usr/share/fonts/default/Type1/fonts.scale
	mkfontdir /usr/share/fonts/default/Type1
}
