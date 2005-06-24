# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/perdition/perdition-1.15.ebuild,v 1.2 2005/06/24 22:42:19 agriffis Exp $

inherit eutils

DESCRIPTION="Perdition is a modular and fully featured POP3 and IMAP4 proxy."
SRC_URI="http://www.vergenet.net/linux/${PN}/download/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.vergenet.net/linux/perdition/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="nls pam ssl mysql odbc postgres gdbm ldap"

DEPEND="!net-mail/mailx
	!net-mail/nmh
	dev-util/guile
	>=dev-libs/vanessa-logger-0.0.6
	>=dev-libs/vanessa-adt-0.0.6
	>=net-libs/vanessa-socket-0.0.7
	ssl? ( dev-libs/openssl )
	odbc? ( dev-db/unixODBC )
	gdbm? ( sys-libs/gdbm )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	ldap? ( net-nds/openldap )
	pam? ( sys-libs/pam )
	nls? ( sys-devel/gettext )"

src_compile() {
	econf --disable-sendmail \
		$(use_enable nls) \
		$(use_enable pam) \
		$(use_enable ssl) \
		$(use_enable mysql) \
		$(use_enable odbc) \
		$(use_enable postgres) \
		$(use_enable gdbm) \
		$(use_enable ldap) || die

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README AUTHORS TODO

	newinitd "${FILESDIR}/perdition.initd" perdition
	insinto /etc/conf.d; newins "${FILESDIR}/perdition.confd" perdition

	keepdir /var/run/perdition
}

pkg_preinst() {
	einfo "Checking for user perdition, creating if missing"
	enewuser perdition
	chown perdition ${IMAGE}/var/run/perdition
}
