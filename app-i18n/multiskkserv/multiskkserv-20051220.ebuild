# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/multiskkserv/multiskkserv-20051220.ebuild,v 1.1 2007/04/23 14:10:31 matsuu Exp $

inherit eutils fixheadtails

DESCRIPTION="SKK server that handles multiple dictionaries"
HOMEPAGE="http://www3.big.or.jp/~sian/linux/products/"
SRC_URI="http://www3.big.or.jp/~sian/linux/products/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-db/cdb"
RDEPEND="app-i18n/skk-jisyo-cdb"

PROVIDE="virtual/skkserv"

src_unpack() {
	unpack ${A}

	cd "${S}"
	ht_fix_all
}

src_compile() {
	econf --with-cdb=yes || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	newconfd "${FILESDIR}"/multiskkserv.conf multiskkserv
	newinitd "${FILESDIR}"/multiskkserv.initd multiskkserv

	dodoc AUTHORS ChangeLog NEWS README*
}

pkg_postinst() {
	elog "By default, multiskkserv will look up only SKK-JISYO.L.cdb."
	elog "If you want to use more dictionaries,"
	elog "edit /etc/conf.d/multiskkserv manually."
}
