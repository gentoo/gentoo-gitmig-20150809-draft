# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hk_classes/hk_classes-0.7_alpha3.ebuild,v 1.1 2004/07/04 13:59:57 carlo Exp $

MY_P=${P/_alpha/-test}
S=${WORKDIR}/${MY_P}

DESCRIPTION="GUI-independent C++ libraries for database applications, including API documentation and tutorials."
HOMEPAGE="http://hk-classes.sourceforge.net/"
SRC_URI="mirror://sourceforge/hk-classes/${MY_P}.tar.bz2
		 mirror://sourceforge/knoda/knodapython.tar.bz2
		 mirror://sourceforge/knoda/hk_docs-0.6.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="mysql postgres odbc doc"

# At least one of the following is required
DEPEND="mysql? ( >=dev-db/mysql-3.23.54a )
	postgres? ( >=dev-db/postgresql-7.3 )
	odbc? ( >=dev-db/unixODBC-2.0.6 )"

src_compile() {
	./configure || die "./configure failed"
	emake || die
}

src_install() {
	use doc && dohtml -r ${WORKDIR}/hk_docs-0.6
	use doc && dohtml -r ${WORKDIR}/knodapythondoc
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	echo
	einfo "hk_classes has been installed in /usr/lib/hk_classes"
	if use mysql
	then
		einfo "MySQL driver is installed in /usr/lib/hk_classes/drivers"
	fi
	if use postgres
	then
		einfo "PostgreSQL driver is installed in /usr/lib/hk_classes/drivers"
	fi
	if use odbc
	then
		einfo "ODBC driver is installed in /usr/lib/hk_classes/drivers"
	fi
	if use doc
	then
		echo
		einfo "API documentation and tutorial are installed in"
		einfo " /usr/share/doc/${P}/html/hk_docs-0.6"
		einfo "A small Python tutorial is installed in"
		einfo " /usr/share/doc/${P}/html/knodapythondoc"
	fi
	echo
}
