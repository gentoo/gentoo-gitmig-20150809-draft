# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/gosa-plugin-samba/gosa-plugin-samba-2.6.10.ebuild,v 1.1 2010/07/29 10:01:12 dev-zero Exp $

EAPI=3

inherit eutils

DESCRIPTION="GOsa plugin for Samba integration"
HOMEPAGE="https://oss.gonicus.de/labs/gosa/wiki/WikiStart."
SRC_URI="ftp://oss.gonicus.de/pub/gosa/${P}.tar.bz2
	http://oss.gonicus.de/pub/gosa/${P}.tar.bz2
	ftp://oss.gonicus.de/pub/gosa/archive/${P}.tar.bz2
	http://oss.gonicus.de/pub/gosa/archive/${P}.tar.bz2	"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/php[iconv,imap,ldap,mysql,session,zip]
	sys-devel/gettext"
RDEPEND="${DEPEND}
	~net-nds/gosa-core-${PV}"

src_install() {
	insinto /usr/share/gosa/html/plugins/samba/
	doins -r html/*

	insinto /usr/share/gosa/locale/plugins/samba/
	doins -r locale/*

	insinto /usr/share/gosa/plugins
	doins -r admin personal

	insinto /usr/share/gosa/doc/plugins/samba/
	doins help/guide.xml

	dodoc contrib/*
}

pkg_postinst() {
	ebegin "Updating class cache and locales"
	"${EROOT}"usr/sbin/update-gosa
	eend $?
}
