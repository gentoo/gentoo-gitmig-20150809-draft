# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-uncommonsql-postgresql/cl-uncommonsql-postgresql-1.2.0.ebuild,v 1.1 2003/06/19 05:49:58 mkennedy Exp $

inherit common-lisp

DESCRIPTION="PostgreSQL interface for UncommonSQL"
HOMEPAGE="http://alpha.onshored.com/lisp-software/#uncommonsql"
SRC_URI="http://alpha.onshored.com/debian/local/${PN/-postgresql/}_${PV}.orig.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-uncommonsql"
RDEPEND="${DEPEND}
	dev-db/postgresql"

CLPACKAGE=uncommonsql-postgresql

S=${WORKDIR}/${P/-postgresql/}

src_install() {
	insinto /usr/share/common-lisp/source/uncommonsql/dbms/postgresql
	doins dbms/postgresql/*.lisp

	dosym /usr/share/common-lisp/source/uncommonsql \
		/usr/share/common-lisp/source/uncommonsql-postgresql
	dodir /usr/share/common-lisp/systems
	grep -v mk:oos dbms/postgresql/system.lisp \
		>${D}/usr/share/common-lisp/systems/uncommonsql-postgresql.system

	dodoc CONTRIB* COPYING ChangeLog INSTALL README VERSION TODO
}
