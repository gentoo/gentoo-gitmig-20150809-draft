# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/directoryadministrator/directoryadministrator-1.5.1.ebuild,v 1.7 2006/06/01 11:32:25 jokey Exp $

MY_PN="directory_administrator"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="GUI to manage users and groups in a LDAP directory"
SRC_URI="http://diradmin.open-it.org/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://diradmin.open-it.org"
LICENSE="GPL-2"
DEPEND="gnome-base/gnome-libs
	net-nds/openldap
	=sys-libs/db-1.8*"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

src_install () {
	einstall || die

	dodoc AUTHORS ChangeLog CREDITS NEWS README TODO
	dodoc doc/*
	docinto misc_docs
	dodoc doc/misc_docs/*
	docinto pam.d
	dodoc doc/pam.d/*
}
