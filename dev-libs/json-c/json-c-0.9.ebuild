# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/json-c/json-c-0.9.ebuild,v 1.5 2011/09/04 21:02:28 maekke Exp $

EAPI="2"

DESCRIPTION="A JSON implementation in C"
HOMEPAGE="http://oss.metaparadigm.com/json-c/"
SRC_URI="http://oss.metaparadigm.com/json-c/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README || die "dodoc failed"
	dohtml README.html || die "dohtml failed"
}
