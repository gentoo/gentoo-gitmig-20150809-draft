# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/directoryadministrator/directoryadministrator-1.5.1.ebuild,v 1.4 2004/06/08 04:28:20 raker Exp $

MY_PN="directory_administrator"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="GUI to manage users and groups in a LDAP directory"
SRC_URI="http://diradmin.open-it.org/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://diradmin.open-it.org"
LICENSE="GPL-2"
DEPEND=">=gnome-base/gnome-libs-1.2.0
	>=net-nds/openldap-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS ChangeLog COPYING CREDITS INSTALL NEWS README TODO
	dodoc doc/*
	docinto misc_docs
	dodoc doc/misc_docs/*
	docinto pam.d
	dodoc doc/pam.d/*
}

pkg_postinst() {
	ewarn "NOTE: You need to enable LDAPv2 support for directory_administrator"
	ewarn "to work properly.  If you are running openldap-2.1.x,"
	ewarn "add this line to /etc/openldap/slapd.conf"
	einfo ""
	einfo "allow	bind_v2"
	einfo ""
}
