# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/sswf/sswf-1.8.0-r1.ebuild,v 1.1 2007/04/18 20:16:31 drac Exp $

DESCRIPTION="A C++ Library and a script language tool to create Flash (SWF) movies up to version 8."
HOMEPAGE="http://sswf.sourceforge.net"
SRC_URI="ftp://ftp.m2osw.com/${PN}/beta/${P}-src.tar.gz
	ftp://ftp.m2osw.com/${PN}/beta/${P}-doc.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug doc examples"

RDEPEND="sys-libs/zlib
	media-libs/jpeg
	media-libs/freetype
	sys-devel/flex
	sys-devel/bison"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --disable-docs $(use_enable debug)
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."

	dodoc README.txt doc/{NOTES,TODO,LINKS,AUTHORS,ASC-TODO,CHANGES}.txt
	rm -f "${D}"/usr/share/${PN}/*.txt

	use examples || rm -rf "${D}"/usr/share/${PN}/samples

	doman doc/man/man1/*.1

	if use doc; then
		doman doc/man/man3/*.3
		dohtml -r doc/html/*
	fi
}
