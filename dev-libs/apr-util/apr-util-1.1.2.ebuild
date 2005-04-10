# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr-util/apr-util-1.1.2.ebuild,v 1.1 2005/04/10 21:37:05 trapni Exp $


DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="1"

RESTRICT="maketest"

IUSE="berkdb gdbm ldap"

DEPEND=">=sys-apps/sed-4
		dev-libs/expat
		>=dev-libs/apr-1.1.0
		berkdb? ( sys-libs/db )
		gdbm? ( sys-libs/gdbm )
		ldap? ( =net-nds/openldap-2* )"

src_compile() {
	myconf=""

	if use ldap; then
		myconf="${myconf} --with-ldap"
	fi

	if use berkdb; then
		if has_version '=sys-libs/db-4.2*'; then
			myconf="${myconf} --with-dbm=db42 --with-berkely-db=/usr"
		elif has_version '=sys-libs/db-4*'; then
			myconf="${myconf} --with-dbm=db4 --with-berkely-db=/usr"
		elif has_version '=sys-libs/db-3*'; then
			myconf="${myconf} --with-dbm=db3 --with-berkely-db=/usr"
		elif has_version '=sys-libs/db-2'; then
			myconf="${myconf} --with-dbm=db2 --with-berkely-db=/usr"
		fi
	fi

	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share/apr-util-1 \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--with-apr=/usr \
		$myconf || die

	emake || die
}

src_install() {
	einstall installbuilddir=${D}/usr/share/apr-util-1/build

	#bogus values pointing at /var/tmp/portage
	sed -i -e 's:APU_SOURCE_DIR=.*:APU_SOURCE_DIR=:g' ${D}/usr/bin/apu-1-config
	sed -i -e 's:APU_BUILD_DIR=.*:APU_BUILD_DIR=/usr/share/apr-util-1/build:g' ${D}/usr/bin/apu-1-config

	dodoc CHANGES LICENSE NOTICE
}
