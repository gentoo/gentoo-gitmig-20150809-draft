# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/flickrfs/flickrfs-1.3.9.ebuild,v 1.1 2007/06/24 03:53:27 jmglov Exp $

inherit distutils eutils

DESCRIPTION="Flickrfs is a virtual filesystem based upon FUSE that provides easy access to flickr."
HOMEPAGE="http://manishrjain.googlepages.com/flickrfs"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~x86"

RDEPEND="
	=dev-lang/python-2.4*
	sys-fs/fuse-python
	media-gfx/imagemagick"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A} && cd ${S}

	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install

	dobin ${FILESDIR}/flickrfs
}
