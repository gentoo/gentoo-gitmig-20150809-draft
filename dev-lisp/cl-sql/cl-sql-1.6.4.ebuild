# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-sql/cl-sql-1.6.4.ebuild,v 1.6 2004/07/14 16:15:34 agriffis Exp $

inherit common-lisp

DESCRIPTION="A multi-platform SQL interface for Common Lisp"
HOMEPAGE="http://clsql.med-info.com/
	http://packages.debian.org/unstable/devel/cl-sql.html
	http://www.cliki.net/CLSQL"
SRC_URI="http://files.b9.com/clsql/clsql-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="postgres"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-uffi
	postgres? ( dev-db/postgresql )"

S=${WORKDIR}/clsql-${PV}

modules='clsql-base clsql clsql-postgresql-socket clsql-uffi'

# TODO: add the MySQL support

src_compile() {
	make -C uffi
}

src_install() {
	local clsrc=/usr/share/common-lisp/source
	local clsys=/usr/share/common-lisp/systems

	dodir $clsys

	insinto $clsrc/clsql/sql ; doins sql/*.lisp
	insinto $clsrc/clsql ; doins clsql.asd
	dosym $clsrc/clsql/clsql.asd $clsys/clsql.asd

	insinto $clsrc/clsql-base/base ; doins base/*.lisp
	insinto $clsrc/clsql-base ; doins clsql-base.asd
	dosym $clsrc/clsql-base/clsql-base.asd $clsys/clsql-base.asd

	exeinto /usr/lib/clsql/
	doexe uffi/clsql-uffi.so

	insinto $clsrc/clsql-uffi/uffi ; doins uffi/*.lisp
	insinto $clsrc/clsql-uffi ; doins clsql-uffi.asd
	dosym $clsrc/clsql-uffi/clsql-uffi.asd $clsys/clsql-uffi.asd

	insinto $clsrc/clsql-postgresql-socket/db-postgresql-socket ; doins db-postgresql-socket/*.lisp
	insinto $clsrc/clsql-postgresql-socket ; doins clsql-postgresql-socket.asd
	dosym $clsrc/clsql-postgresql-socket/clsql-postgresql-socket.asd $clsys/clsql-postgresql-socket.asd

	if use postgres ; then
		insinto $clsrc/clsql-postgresql/db-postgresql ; doins db-postgresql/*.lisp
		insinto $clsrc/clsql-postgresql ; doins clsql-postgresql.asd
		dosym $clsrc/clsql-postgresql/clsql-postgresql.asd $clsys/clsql-postgresql.asd
	fi

	dodoc COPYING* ChangeLog INSTALL NEWS README TODO
	tar xfz doc/html.tar.gz -C ${D}/usr/share/doc/${P}/
}

pkg_postinst() {
	for i in $modules ; do
		/usr/sbin/register-common-lisp-source $i
	done
	use postgres && /usr/sbin/register-common-lisp-source clsql-postgresql
}

pkg_prerm() {
	for i in $modules ; do
		/usr/sbin/unregister-common-lisp-source $i
	done
	/sbin/unregister-common-lisp-source clsql-postgresql
}
