# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland/redland-1.0.4.ebuild,v 1.13 2009/05/12 08:50:20 ssuominen Exp $

inherit eutils

DESCRIPTION="High-level interface for the Resource Description Framework"
HOMEPAGE="http://librdf.org/"
SRC_URI="http://librdf.org/dist/source/${P}.tar.gz"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE="berkdb mysql sqlite ssl threads"

RDEPEND="mysql? ( virtual/mysql )
	sqlite? ( =dev-db/sqlite-3* )
	berkdb? ( sys-libs/db )
	dev-libs/libxml2
	ssl? ( dev-libs/openssl )
	>=media-libs/raptor-1.4.4
	>=dev-libs/rasqal-0.9.6"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.0.3-configure.patch
	epatch "${FILESDIR}"/${PN}-1.0.4-CFLAGS.patch
	rm -r "${S}"/{raptor,rasqal}
}

src_compile() {
	econf \
		--with-raptor=system \
		--with-rasqal=system \
		$(use_with berkdb bdb) \
		$(use_with ssl openssl-digests) \
		$(use_with mysql) \
		$(use_with threads) \
		$(use_with sqlite) \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog* INSTALL NEWS README TODO
	dohtml *.html
}
