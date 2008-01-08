# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mini-xml/mini-xml-2.4.ebuild,v 1.2 2008/01/08 02:21:39 carlo Exp $

inherit autotools multilib

MY_P="${P/mini-xml/mxml}"

DESCRIPTION="Mini-XML is a small XML parsing library that you can use to read XML and XML-like data files in your application without requiring large non-standard libraries."
HOMEPAGE="http://www.easysw.com/~mike/mxml"
SRC_URI="http://ftp.easysw.com/pub/mxml/${PV}/${MY_P}.tar.gz"

LICENSE="Mini-XML"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-util/pkgconfig"
RDEPEND=""

S="${WORKDIR}/${MY_P}"


src_test() {
	emake testmxml
}

src_compile() {
	sed -i -e "s:755 -s:755:" Makefile.in || die "sed failed"
	rm configure
	eautoreconf

	econf --enable-shared  --libdir="/usr/$(get_libdir)" --with-docdir="/usr/share/doc/${PF}/html"
	emake libmxml.a  libmxml.so.1.4 mxmldoc doc/mxml.man
}

src_install() {
	emake DSTROOT="${D}" install || die "install failed"
	dodoc ANNOUNCEMENT CHANGES README
	rm "${D}/usr/share/doc/${PF}/html/"{CHANGES,COPYING,README}
}
