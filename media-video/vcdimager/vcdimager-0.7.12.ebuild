# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Matthew Turk <m-turk@nwu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdimager/vcdimager-0.7.12.ebuild,v 1.1 2002/05/20 00:01:43 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU VCDimager"
SRC_URI="http://www.vcdimager.org/pub/vcdimager/vcdimager-0.7_UNSTABLE/${P}.tar.gz"
HOMEPAGE="http://www.vcdimager.org"
LICENSE="GPL"

# Ideally this would also include help2man, but it's not yet in portage.
DEPENDS="xml2 ? ( >= dev-libs/libxml2-2.3.8 )"

src_compile() {

	local myopts

	# We disable the xmltest because the configure script includes differently
	# than the actual XML-frontend C files.

	use xml2 \
	&& myopts="${myopts} --with-xml-prefix=/usr --disable-xmltest" \
	|| myopts="${myopts} --without-xml-frontend"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myopts} \
		|| die "./configure failed"

	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
}

