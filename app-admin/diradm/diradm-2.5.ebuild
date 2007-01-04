# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/diradm/diradm-2.5.ebuild,v 1.3 2007/01/04 21:13:11 beandog Exp $

DESCRIPTION="diradm is a nearly complete nss/shadow suite for managing POSIX users/groups/data in LDAP."
HOMEPAGE="http://research.iat.sfu.ca/custom-software/diradm/"
SRC_URI="${HOMEPAGE}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="samba irixpasswd automount"
DEPEND="net-nds/openldap
	virtual/perl-MIME-Base64
	samba? (
		dev-perl/Crypt-SmbHash
		>=net-fs/samba-3.0.6
	)"

src_compile() {
	local myconf
	myconf="`use_enable samba` `use_enable automount` `use_enable irixpasswd`"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc CHANGES* README AUTHORS COPYING ChangeLog NEWS README.prefork THANKS TODO
	if use irixpasswd; then
		insinto /etc/openldap/schema
		doins irixpassword.schema
	fi
}

pkg_postinst() {
	einfo "The new diradm pulls many settings from your LDAP configuration."
	einfo "But don't forget to customize /etc/diradm.conf for other settings."
	einfo "Please see the README to instructions if you problems."
}
