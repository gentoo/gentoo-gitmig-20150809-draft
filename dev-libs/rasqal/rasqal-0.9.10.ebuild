# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rasqal/rasqal-0.9.10.ebuild,v 1.8 2008/05/12 09:29:01 aballier Exp $

DESCRIPTION="library that handles Resource Description Framework (RDF)"
HOMEPAGE="http://librdf.org/rasqal/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE="pcre xml"

RDEPEND="pcre? ( dev-libs/libpcre )
	xml? ( dev-libs/libxml2 )
	media-libs/raptor"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_compile() {
	local regexlib
	use pcre && regexlib="pcre" || regexlib="posix"
	econf \
		$(use_with pcre pcre-config) \
		$(use_with xml xml2-config) \
		--with-regex-library=${regexlib} \
		--with-raptor=system \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README
}
