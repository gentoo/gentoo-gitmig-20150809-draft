# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vchkuser/vchkuser-0.3.2.ebuild,v 1.1 2009/05/23 09:57:11 hollow Exp $

EAPI="2"

inherit autotools qmail

DESCRIPTION="qmail-spp plugin to check recipient existance with vpopmail"
HOMEPAGE="http://bb.xnull.de/projects/vchkuser/"
SRC_URI="http://bb.xnull.de/projects/vchkuser/dist/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="net-mail/vpopmail
	|| ( mail-mta/netqmail[qmail-spp] mail-mta/qmail-ldap[qmail-spp] )"
RDEPEND=""

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		--with-vpopuser=vpopmail \
		--with-qmailgroup=nofiles \
		--with-vpopmaildir=/var/vpopmail \
		--with-qmaildir=${QMAIL_HOME}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	fowners vpopmail:nofiles "${QMAIL_HOME}"/plugins/vchkuser
	fperms 4750 "${QMAIL_HOME}"/plugins/vchkuser
}
