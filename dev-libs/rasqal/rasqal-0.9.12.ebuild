# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rasqal/rasqal-0.9.12.ebuild,v 1.1 2006/07/02 06:47:25 vapier Exp $

inherit eutils

DESCRIPTION="library that handles Resource Description Framework (RDF)"
HOMEPAGE="http://librdf.org/rasqal/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="pcre xml"

RDEPEND="sys-devel/flex
	pcre? ( dev-libs/libpcre )
	xml? ( dev-libs/libxml2 )
	>=media-libs/raptor-1.4.9"
DEPEND="${RDEPEND}
	sys-devel/bison"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-typos.patch
}

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
