# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpgalleg/jpgalleg-2.5.ebuild,v 1.4 2010/02/23 09:54:16 phajdan.jr Exp $

DESCRIPTION="The jpeg loading routines are able to load almost any JPG image file with Allegro"
HOMEPAGE="http://www.ecplusplus.com/index.php?page=projects&pid=1"
SRC_URI="http://www.ecplusplus.com/files/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=media-libs/allegro-4"
DEPEND="${RDEPEND}"

src_compile() {
	./fix.sh unix --quick
	emake || die
}

src_install() {
	dodir /usr
	dodir /usr/include
	dodir /usr/lib

	emake install INSTALL_BASE_PATH="${D}usr" || die

	dodoc readme.txt

	insinto /usr/share/doc/${PF}/examples
	doins examples/*.{c,dat,h,jpg,tga}
}
