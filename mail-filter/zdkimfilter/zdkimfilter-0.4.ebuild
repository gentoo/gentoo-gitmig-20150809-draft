# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/zdkimfilter/zdkimfilter-0.4.ebuild,v 1.2 2010/08/01 06:29:50 dragonheart Exp $

EAPI=2
DESCRIPTION="DKIM filter for Courier-MTA"
HOMEPAGE="http://www.tana.it/sw/zdkimfilter"
SRC_URI="http://www.tana.it/sw/zdkimfilter/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="mail-filter/opendkim
		mail-mta/courier"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable debug) || die "failed to configure"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm "${D}"/etc/courier/filters/zdkimfilter.conf
	diropts -o mail -g mail
	dodir /etc/courier/filters/keys
}
