# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db/foomatic-db-20030716.ebuild,v 1.5 2003/09/07 00:18:10 msterret Exp $

DESCRIPTION="Foomatic printer database"
HOMEPAGE="http://www.linuxprinting.org/foomatic"
SRC_URI="mirror://gentoo/foomatic-db-${PV}.tar.gz
	http://www.linuxprinting.org/download/foomatic/foomatic-db-engine-3.0.0.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="cups ppds"

S=${WORKDIR}/foomatic

DEPEND="dev-libs/libxml2
	net-misc/wget
	net-ftp/curl
	net-print/foomatic-filters
	net-print/foomatic-db-engine"

src_unpack() {
	mkdir foomatic
	cd foomatic
	unpack foomatic-db-engine-3.0.0.tar.gz
	unpack foomatic-db-${PV}.tar.gz
}

src_compile() {
	cd foomatic-db-${PV}
	econf
	emake || die
	rm db/source/driver/stp.xml
	cd ..

	if [ `use ppds` ]; then
		cd foomatic-db-engine-3.0.0
		epatch ${FILESDIR}/perl-module.diff
		cp Makefile.in Makefile.in.orig
		sed s:'cp\ \$\${foomatic_filters_root}/\*\.1':'cp\ \*\.1': \
		  < Makefile.in.orig > Makefile.in
		econf
		make inplace
		rm foomatic-rip
		ln -s /usr/bin/foomatic-rip ./foomatic-rip
		#./foomatic-cleanupdrivers
		./foomatic-preferred-driver
		make DESTDIR=${D} filters-ppds || die
		cd ..
	fi
}

src_install() {
	cd foomatic-db-${PV}
	make DESTDIR=${D} install || die "make install failed"

	if [ `use ppds` ]; then
		cd ../foomatic-db-engine-3.0.0
		tar -xzf foomatic-filters-ppds-${PV}.tar.gz

		dodir /usr/share/ppd
		cp -R  foomatic-filters-ppds-${PV}/share/ppd/* ${D}/usr/share/ppd
		gzip -rf ${D}/usr/share/ppd
		if [ `use cups` ]; then
			dodir /usr/share/cups/model
			dosym /usr/share/ppd /usr/share/cups/model/foomatic-ppds
		fi
	fi
}
