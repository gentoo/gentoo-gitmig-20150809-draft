# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba-tng/samba-tng-0.3.2.ebuild,v 1.1 2003/06/26 23:29:16 vapier Exp $

DESCRIPTION="The Next Generation of Samba"
HOMEPAGE="http://www.samba-tng.org/"
SRC_URI="http://download.samba-tng.org/tng/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="afs kerberos pam ldap cups tcpd"

DEPEND="afs? ( net-fs/openafs )
	kerberos? ( virtual/krb5 )
	pam? ( >=sys-libs/pam-0.72 )
	ldap? ( net-nds/openldap )
	cups? ( net-print/cups )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
RDEPEND="${DEPEND}
	!net-fs/samba"

src_compile() {
	cd source
	#local ldapconf=""
	#use ldap && ldapconf="--with-passdb=ldap"
	# couldnt get these to compile for me
	#	--with-smbwrapper \
	#	`use_with kerberos krb5` \
	#	${ldapconf} \
	#	`use_with afs` \
	econf \
		--with-automount \
		--with-smbmount \
		`use_with pam` \
		--with-passdb=smbpass \
		`use_with cups` \
		`use_with tcpd tcpwrappers` \
		|| die
	emake || die
}

src_install() {
	dodoc NEWS README ROADMAP
	docinto examples
	dodoc examples/*
	cd source
	make install DESTDIR=${D} || die
}
