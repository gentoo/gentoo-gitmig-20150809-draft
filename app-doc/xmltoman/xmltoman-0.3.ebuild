# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/xmltoman/xmltoman-0.3.ebuild,v 1.9 2009/05/30 18:04:19 nixnut Exp $

DESCRIPTION="Simple scripts for converting xml to groff or html"
HOMEPAGE="http://packages.debian.org/unstable/devel/xmltoman"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/XML-Parser"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"
	dodoc README
	doman xmltoman.1 xmlmantohtml.1
}
