# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnugk/gnugk-2.2.1.ebuild,v 1.1 2005/03/24 22:14:03 pvdabeel Exp $

inherit eutils

IUSE="mysql postgres ldap radius"

DESCRIPTION="GNU H.323 gatekeeper"
HOMEPAGE="http://www.gnugk.org/"
SRC_URI="mirror://sourceforge/openh323gk/gnugk-${PV}.tgz"

S=${WORKDIR}/openh323gk

MY_OS="`uname -s | tr [:upper:] [:lower:]`"

SLOT="0"
KEYWORDS="~ppc"
LICENSE="GPL-2"

DEPEND="net-libs/openh323
	mysql? ( dev-db/mysql++ )
	postgres? ( dev-db/postgresql )
	ldap?  ( net-nds/openldap )"

src_compile() {
	econf \
	        `use_enable mysql` \
			`use_enable ldap` \
			`use_enable postgres sql` \
			`use_enable radius` || die
	emake optdepend opt || die
}

src_install() {
	dodir /usr/sbin /etc/gnugk
	dosbin obj_${MY_OS}_${ARCH}_r/gnugk

	insinto /etc/gnugk
	doins etc/*

	if use ldap && [ -d /etc/openldap/schema ]; then
		insinto /etc/openldap/schema
		doins etc/voip.schema
		rm -f ${D}/etc/gnugk/voip.schema
	fi

	dodoc changes.txt readme.txt copying docs/*
	mv ${D}/etc/gnugk/*.pl ${D}/usr/share/doc/${PF}

	docinto old
	dodoc docs/old/*

	exeinto /etc/init.d/
	newexe ${FILESDIR}/gnugk.rc6 gnugk

	insinto /etc/conf.d/
	newins ${FILESDIR}/gnugk.confd gnugk
}
