# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hpijs/hpijs-1.5.ebuild,v 1.7 2004/06/02 02:29:03 lv Exp $

inherit gnuconfig eutils

DB_V=${PV}-20031125
DESCRIPTION="The HP Inkjet server for Ghostscript. Provides best output for HP Inkjet Printers and some LaserJets"
HOMEPAGE="http://hpinkjet.sourceforge.net/"
SRC_URI="mirror://sourceforge/hpinkjet/${P}.tar.gz
	http://www.linuxprinting.org/download/foomatic/foomatic-db-hpijs-${DB_V}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa amd64"
IUSE="cups foomaticdb ppds"

DEPEND="virtual/ghostscript
	cups? ( net-print/cups )
	net-print/foomatic-filters
	foomaticdb? ( net-print/foomatic-db-engine )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use amd64 && gnuconfig_update
	epatch ${FILESDIR}/${P}-gcc34.patch
	epatch ${FILESDIR}/hpijs-1.4.1-rss.1.patch
}

src_compile () {
	econf \
		--disable-cups-install \
		`use_enable ppds foomatic-install` \
		|| die "econf failed"

	for i in Makefile; do
		mv $i $i.orig ;
		cat $i.orig | \
			sed -e 's|/usr/share/cups|${prefix}/share/cups|g' | sed -e 's|/usr/lib/cups|${prefix}/lib/cups|g' > $i
	done

	make || die "compile problem"

	if use foomaticdb ; then
		cd ../foomatic-db-hpijs-${DB_V}
		econf || die "econf failed"
		rm -fR data-generators/hpijs-rss
		make || die
		cd ../${P}
	fi
}

src_install() {
	einstall || die

	if use cups && use ppds ; then
		dodir /usr/share/cups/model
		dosym /usr/share/ppd /usr/share/cups/model/foomatic-ppds
	fi

	use ppds && rm -f ${D}/usr/bin/foomatic-rip

	if use foomaticdb ; then
		cd ../foomatic-db-hpijs-${DB_V}
		make DESTDIR=${D} install || die
	fi
}

pkg_postinst() {
	einfo "To use the hpijs driver with the PDQ spooler you will need the PDQ driver file"
	einfo "for your printer from http://www.linuxprinting.org/show_driver.cgi?driver=hpijs"
	einfo "This file should be installed in /etc/pdq/drivers"
	einfo
	einfo "The hpijs ebuild no longer creates the ppds automatically, please use foomatic"
	einfo "to do so or remerge hpijs with the ppds use flag."
}
