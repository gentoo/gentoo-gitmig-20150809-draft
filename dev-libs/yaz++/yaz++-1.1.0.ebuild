# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/yaz++/yaz++-1.1.0.ebuild,v 1.1 2008/04/21 19:11:56 drac Exp $

inherit eutils autotools flag-o-matic

MY_PN=${PN/++/pp}

DESCRIPTION="C++ addon for the yaz development libraries"
HOMEPAGE="http://www.indexdata.dk/yazplusplus"
SRC_URI="http://ftp.indexdata.dk/pub/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/yaz-3.0.26"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	append-ldflags -Wl,--no-as-needed # FIXME.
	econf
	emake || die "emake failed"
}

src_install() {
	docdir="/usr/share/doc/${PF}"
	emake DESTDIR="${D}" docdir="${docdir}" install || die "install failed"

	dodoc ChangeLog NEWS README TODO
	docinto html
	mv -f "${D}"/${docdir}/*.html "${D}"/${docdir}/html/ || die "Failed to move HTML docs"
	mv -f "${D}"/usr/share/doc/${MY_PN}/common "${D}"/${docdir}/html/ || die "Failed to move HTML docs"
	rm -rf "${D}"/usr/share/doc/${MY_PN}
}
