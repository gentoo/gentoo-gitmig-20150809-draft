# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdimager/vcdimager-0.7.19.ebuild,v 1.6 2004/02/07 19:37:41 vapier Exp $

DESCRIPTION="GNU VCDimager"
HOMEPAGE="http://www.vcdimager.org/"
SRC_URI="mirror://sourceforge/xine/${P}-cdio.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~amd64"
IUSE="xml2"

DEPEND=">=dev-libs/libcdio-0.64
	xml2? ( >=dev-libs/libxml2-2.5.11 )"

S=${WORKDIR}/${P}-cdio

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

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS BUGS COPYING ChangeLog FAQ HACKING INSTALL
	dodoc NEWS README THANKS TODO
}
