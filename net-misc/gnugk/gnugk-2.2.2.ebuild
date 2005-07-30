# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnugk/gnugk-2.2.2.ebuild,v 1.1 2005/07/30 00:33:14 stkn Exp $

IUSE="mysql postgres radius"

DESCRIPTION="GNU H.323 gatekeeper"
HOMEPAGE="http://www.gnugk.org/"
SRC_URI="mirror://sourceforge/openh323gk/gnugk-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

DEPEND="
	>=dev-libs/pwlib-1.8.4
	>=net-libs/openh323-1.15.3
	mysql? ( dev-db/mysql++ )
	postgres? ( dev-db/postgresql )"

src_compile() {
	econf \
	        `use_enable mysql` \
		`use_enable postgres sql` \
		`use_enable radius` || die

	emake optdepend opt addpasswd || die
}

src_install() {
	dosbin obj_*_*_r/gnugk
	dosbin obj_*_*_r/addpasswd

	insinto /etc/gnugk
	doins etc/*

	dodoc changes.txt readme.txt copying docs/*.txt
	mv ${D}/etc/gnugk/*.pl ${D}/usr/share/doc/${PF}

	docinto old
	dodoc docs/old/*

	dodir /usr/share/doc/${PF}/contrib
	cp -r contrib/sqlbill ${D}/usr/share/doc/${PF}/contrib

	newinitd ${FILESDIR}/gnugk.rc6 gnugk
	newconfd ${FILESDIR}/gnugk.confd gnugk
}
