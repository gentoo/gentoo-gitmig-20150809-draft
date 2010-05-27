# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/prelude-lml/prelude-lml-1.0.0.ebuild,v 1.1 2010/05/27 04:56:22 jer Exp $

inherit flag-o-matic

DESCRIPTION="Prelude-IDS Log Monitoring Lackey"
HOMEPAGE="http://www.prelude-technologies.com"
SRC_URI="${HOMEPAGE}/download/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="fam"

DEPEND=">=dev-libs/libprelude-0.9.8
	dev-libs/libpcre"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf

	use fam && myconf="${myconf} --with-fam"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	newinitd "${FILESDIR}"/gentoo.init prelude-lml
	newconfd "${FILESDIR}"/gentoo.conf prelude-lml
}
