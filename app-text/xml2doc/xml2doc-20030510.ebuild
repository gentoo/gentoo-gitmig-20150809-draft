# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xml2doc/xml2doc-20030510.ebuild,v 1.1 2003/10/16 15:11:39 obz Exp $

DESCRIPTION="An XML processor tool that allows for converting documents written in simple XML to a variety of document formats (eg pdf,html,txt,manpage)"
SRC_URI="mirror://sourceforge/${PN}/src/${P}.tgz"
HOMEPAGE="http://xml2doc.sourceforge.net"
LICENSE="GPL-2"

IUSE="pdflib"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=dev-libs/libxml2-2.5
	pdflib? ( >=media-libs/pdflib-4 )"

S=${WORKDIR}/${PN}

src_compile() {

	local myconf=""
	use pdflib || myconf="${myconf} --disable-pdf"

	econf ${myconf} || die
	emake || die

}

src_install() {

	# xml2doc's make install is unfortunately broken
	# binary
	dobin ${S}/src/xml2doc
	# documentation
	dodoc BUGS README TODO
	docinto examples
	dodoc ${S}/examples/*.{xml,png}
	# manpage
	cd ${S}/doc
	${S}/src/xml2doc -oM manpage.xml xml2doc.1
	doman xml2doc.1

}
