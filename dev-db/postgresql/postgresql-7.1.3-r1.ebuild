# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Geert Bevin <gbevin@theleaf.be>
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.1.3-r1.ebuild,v 1.1 2002/01/27 19:01:07 gbevin Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PostgreSQL is a sophisticated Object-Relational DBMS"
SRC_URI="ftp://ftp.easynet.be/postgresql/v${PV}/${P}.tar.gz"
HOMEPAGE="http://www.postgresql.org"

DEPEND="virtual/glibc
		sys-devel/autoconf
		>=sys-libs/readline-4.1
		>=sys-libs/ncurses-5.2
		>=sys-libs/zlib-1.1.3
		tcltk? ( >=dev-lang/tcl-8 )
		java? ( >=virtual/jdk-1.3 >=dev-java/ant-1.3 )
		ssl? ( >=dev-libs/openssl-0.9.6-r1 )
		nls? ( sys-devel/gettext )"
#		perl? ( sys-devel/perl )
#		python? ( >=dev-lang/python-2.2-r4 )

RDEPEND="virtual/glibc
		>=sys-libs/zlib-1.1.3
		tcltk? ( >=dev-lang/tcl-8 )
		java? ( >=virtual/jdk-1.3 )
		ssl? ( >=dev-libs/openssl-0.9.6-r1 )"
#		perl? ( sys-devel/perl )
#		python? ( >=dev-lang/python-2.2-r4 )

src_unpack() {

  unpack postgresql-${PV}.tar.gz

  cd ${S}

}

src_compile() {

	local myconf
	if [ "`use tcltk`" ]
	then
		myconf="--with-tcl"
	fi
#	if [ "`use python`" ]
#	then
#		myconf="$myconf --with-python"
#	fi
#	if [ "`use perl`" ]
#	then
#		myconf="$myconf --with-perl"
#	fi
	if [ "`use java`" ]
	then
		myconf="$myconf --with-java"
	fi
	if [ "`use ssl`" ]
	then
		myconf="$myconf --with-openssl=/usr"
	fi
	if [ "`use nls`" ]
	then
		myconf="$myconf --enable-locale"
	fi
	if [ "`use libg++`" ]
	then
	myconf="$myconf --with-CXX"
	fi

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--docdir=/usr/share/doc/${P} \
		--libdir=/usr/lib \
		--enable-syslog \
		$myconf || die

	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	make DESTDIR=${D} install-all-headers || die
	dodoc COPYRIGHT HISTORY INSTALL README register.txt
	cd ${S}/doc
	dodoc FAQ* KNOWN_BUGS MISSING_FEATURES README*
	dodoc TODO internals.ps bug.template
	dodoc *.tar.gz
	docinto sgml
	dodoc src/sgml/*.{sgml,dsl}
	docinto sgml/ref
	dodoc src/sgml/ref/*.sgml
	docinto sgml/graphics
	dodoc src/graphics/*
	mv ${D}/usr/doc/postgresql/html ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/doc ${D}/mnt
	exeinto /usr/bin

	exeinto /etc/init.d/
	doexe ${FILESDIR}/${PV}/${PN}

	einfo ">>> Execute the following command"
	einfo ">>> ebuild  /var/db/pkg/dev-db/${P}/${P}.ebuild config"
	einfo ">>> to setup the initial database environment."
}


pkg_config() {

	einfo ">>> Creating data directory ..."
	mkdir -p /var/db/${PN}/data
	chown -Rf postgres.postgres /var/db/${PN}
	chmod 700 /var/db/${PN}/data

	einfo ">>> Initializing the database ..."
	if [ -f /var/db/${PN}/data/PG_VERSION ] ; then
		echo -n "A postgres data directory already exists from version "; cat /var/db/${PN}/data/PG_VERSION
		echo "Read the documentation to check how to upgrade to version ${PV}."
	else
		su - postgres -c "/usr/bin/initdb --pgdata /var/db/${PN}/data"
	fi

}
