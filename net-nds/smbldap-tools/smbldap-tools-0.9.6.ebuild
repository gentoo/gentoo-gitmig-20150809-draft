# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/smbldap-tools/smbldap-tools-0.9.6.ebuild,v 1.1 2011/05/06 15:20:19 vostorga Exp $

inherit eutils

DESCRIPTION="Samba LDAP management tools"
HOMEPAGE="https://gna.org/projects/smbldap-tools/"
SRC_URI="http://download.gna.org/smbldap-tools/packages/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND="net-nds/openldap
	net-fs/samba
	dev-perl/perl-ldap
	dev-perl/Crypt-SmbHash
	dev-perl/Digest-SHA1
	dev-perl/Unicode-MapUTF8
	dev-perl/IO-Socket-SSL"
DEPEND="${RDEPEND}"

src_compile() {
	mkdir man
	for i in smbldap-[gpu]*; do
		pod2man --section=8 $i > man/$i.8 || die "generation manpage for ${i} failed"
	done
}

src_install() {
	emake install prefix="${D}/usr" sysconfdir="${D}/etc" || die "emake install failed"

	into /usr
	newsbin configure.pl smbldap-configure.pl

	rm -f "${D}/usr/sbin"/*.spec

	dodoc CONTRIBUTORS ChangeLog FILES INFRA README TODO doc/*.conf

	doman man/*

	insinto /usr/share/doc/${PF}
	doins -r doc/migration_scripts
	doins doc/*.pdf
}

pkg_postinst() {
	elog "- A good howto is found on http://download.gna.org/smbldap-tools/docs/samba-ldap-howto/"
	elog "  and http://download.gna.org/smbldap-tools/docs/smbldap-tools/"
	elog "- The configure script is installed as smbldap-configure.pl. Please run it to configure the tools."
	elog "- Examples configuration files for Samba and slapd have been copied to /usr/share/doc/${PF},"
	elog "  together with the migration-scripts."
}
