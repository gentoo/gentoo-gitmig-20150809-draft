# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/smbldap-tools/smbldap-tools-0.9.1.ebuild,v 1.1 2005/06/17 14:48:05 satya Exp $


inherit eutils

MY_PN=${PN/-*/}
S=${WORKDIR}/${PF}
DESCRIPTION="Idealx samba ldap management tools"
SRC_URI="http://samba.idealx.org/dist/${PF}.tgz"
HOMEPAGE="http://samba.idealx.org"

IUSE="doc"
DEPEND="net-nds/openldap
	>=net-fs/samba-3.0.1
	dev-perl/perl-ldap
	dev-perl/Crypt-SmbHash
	dev-perl/Digest-SHA1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

src_compile() {
	einfo "COMPILE: nothing to compile; scripts package"
}

src_install() {
	local prefix=/opt/IDEALX
	local sysconfdir=/etc/opt/IDEALX
	local sbin_dir="${prefix}/sbin/"
	local sbin_ln_dir="/usr/sbin/"
	local script_list="${MY_PN}-*"
	#legacy install
	cd ${S}
	make install prefix=${D}/${prefix} sysconfdir=${D}/${sysconfdir}
	#libs
	exeinto /etc/samba ; doexe smbldap_tools.pm
	eval `perl '-V:installarchlib'`
	dodir ${installarchlib}
	dosym /etc/samba/smbldap_tools.pm ${installarchlib}
	dosym /etc/samba/smbldap_tools.pm ${sbin_dir}
	#scripts
	dodir ${sbin_ln_dir}
	for script in ${script_list}; do
		dosym ${sbin_dir}/${script} ${sbin_ln_dir}/${script}
	done
	#docs
	dodoc CONTRIBUTORS COPYING ChangeLog FILES INFRA INSTALL README TODO
	if use doc; then
		insinto /usr/share/doc/${PF}/doc;      doins ${S}/doc/*
		insinto /usr/share/doc/${PF}/doc/html; doins ${S}/doc/html/*
	fi
}

pkg_postinst() {
	draw_line "                                                           "
	einfo "A good howto is found on http://samba.idealx.org"
	draw_line "                                                           "
}
