# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnugk/gnugk-2.0.6.ebuild,v 1.5 2005/03/24 22:14:03 pvdabeel Exp $

inherit eutils

IUSE="mysql ldap radius accounting"

DESCRIPTION="Advanced H.323 gatekeeper"
HOMEPAGE="http://www.gnugk.org/"
SRC_URI="mirror://sourceforge/openh323gk/gnugk-${PV}.tgz"

S=${WORKDIR}/openh323gk

# avoid problems when using portage on e.g. freebsd
MY_OS="`uname -s | tr [:upper:] [:lower:]`"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND=">=net-libs/openh323-1.12.2-r1
	mysql? ( >=dev-db/mysql++-1.7.9-r2 )
	ldap?  ( net-nds/openldap )"

pkg_setup() {
	# check if under_short does exist
	if use mysql && [ ! -f /usr/include/mysql++/undef_short ]; then
		ewarn "mysql USE flag is set, but mysql++ is missing an"
		ewarn "include file (\"/usr/include/mysql++/undef_short\")"
		ewarn "if emerge fails, please try again with"
		ewarn "    USE="-mysql" emerge ${PN}"
		ebeep 5
		epause 5
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# change include path for mysql++
	epatch ${FILESDIR}/gnugk-${PV}-gentoo.diff
}

src_compile() {
	local myconf

	use ldap && \
		myconf="${myconf} HAS_LDAP=1"

	use mysql || \
		myconf="${myconf} NO_MYSQL=1"

	use radius || \
		myconf="${myconf} NO_RADIUS=1"

	use accounting && \
		myconf="${myconf} HAS_ACCT=1"

	PWLIBDIR=/usr/share/pwlib \
	OPENH323DIR=/usr/share/openh323 \
	emake ${myconf} opt || die
}

src_install() {
	dodir /usr/sbin /etc/gnugk
	dosbin obj_${MY_OS}_${ARCH}_r/gnugk

	insinto /etc/gnugk
	doins etc/*

	# install ldap schema file
	if use ldap && [ -d /etc/openldap/schema ]; then
		insinto /etc/openldap/schema
		doins etc/voip.schema
		rm -f ${D}/etc/gnugk/voip.schema
	fi

	dodoc changes.txt readme.txt copying docs/*
	mv ${D}/etc/gnugk/*.pl ${D}/usr/share/doc/${PF}

	# install old documentation files,
	# they may be useful...
	docinto old
	dodoc docs/old/*

	exeinto /etc/init.d/
	newexe ${FILESDIR}/gnugk.rc6 gnugk

	insinto /etc/conf.d/
	newins ${FILESDIR}/gnugk.confd gnugk
}
