# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdimager/vcdimager-0.7.14.ebuild,v 1.1 2003/04/11 16:16:17 aliz Exp $

IUSE="xml2"

S=${WORKDIR}/${P}
DESCRIPTION="GNU VCDimager"
SRC_URI="http://www.vcdimager.org/pub/vcdimager/vcdimager-0.7_UNSTABLE/${P}.tar.gz"
HOMEPAGE="http://www.vcdimager.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

# Ideally this would also include help2man, but it's not yet in portage.
DEPEND="xml2? ( >=dev-libs/libxml2-2.3.8 )"

src_compile() {

	local myopts

	# We disable the xmltest because the configure script includes differently
	# than the actual XML-frontend C files.

	use xml2 \
	&& myopts="${myopts} --with-xml-prefix=/usr --disable-xmltest" \
	|| myopts="${myopts} --without-xml-frontend"

	econf ${myopts} || die
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS BUGS COPYING ChangeLog FAQ HACKING INSTALL
	dodoc NEWS README THANKS TODO
}
