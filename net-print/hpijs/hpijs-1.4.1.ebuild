# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hpijs/hpijs-1.4.1.ebuild,v 1.4 2003/09/07 00:18:10 msterret Exp $

DESCRIPTION="The HP Inkjet server for Ghostscript. Provides best output for HP Inkjet Printers"
HOMEPAGE="http://hpinkjet.sourceforge.net"
KEYWORDS="x86 ppc alpha sparc hppa amd64"
SRC_URI="mirror://sourceforge/hpinkjet/${P}.tar.gz
	http://www.linuxprinting.org/download/foomatic/foomatic-db-hpijs-1.4-1.tar.gz"
DEPEND="app-text/ghostscript
	cups? ( net-print/cups )
	net-print/foomatic-filters
	foomaticdb? ( net-print/foomatic-db-engine )"
LICENSE="BSD"
SLOT="0"
IUSE="cups foomaticdb ppds"

src_compile () {
	use ppds \
		&& myconf="--enable-foomatic-install" \
		|| myconf="--disable-foomatic-install"

	epatch ${FILESDIR}/hpijs-${PV}-rss.1.patch

	econf --disable-cups-install ${myconf}

	for i in Makefile; do
		mv $i $i.orig ;
		cat $i.orig | \
			sed -e 's|/usr/share/cups|${prefix}/share/cups|g' | sed -e 's|/usr/lib/cups|${prefix}/lib/cups|g' > $i
	done

	make || die "compile problem"

	if [ `use foomaticdb` ]; then
		cd ../foomatic-db-hpijs-1.4-1
		econf
		rm -fR data-generators/hpijs-rss
		make || die
		cd ../${P}
	fi
}

src_install () {
	einstall || die

	if [ "`use cups`" -a "`use ppds`" ] ; then
		dodir /usr/share/cups/model
		dosym /usr/share/ppd /usr/share/cups/model/foomatic-ppds
	fi

	use ppds && rm -f ${D}/usr/bin/foomatic-rip

	if [ `use foomaticdb` ]; then
		cd ../foomatic-db-hpijs-1.4-1
		make DESTDIR=${D} install || die
	fi
}

pkg_postinst () {
	einfo "To use the hpijs driver with the PDQ spooler you will need the PDQ driver file"
	einfo "for your printer from http://www.linuxprinting.org/show_driver.cgi?driver=hpijs"
	einfo "This file should be installed in /etc/pdq/drivers"
	einfo
	einfo "The hpijs ebuild no longer creates the ppds automatically, please use foomatic"
	einfo "to do so or remerge hpijs with the ppds use flag."
}
