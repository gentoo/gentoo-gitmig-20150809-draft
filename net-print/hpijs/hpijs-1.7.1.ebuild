# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hpijs/hpijs-1.7.1.ebuild,v 1.12 2006/12/28 19:01:41 the_paya Exp $

inherit eutils gnuconfig

DB_V=1.5-20041220
DESCRIPTION="The HP Inkjet server for Ghostscript. Provides best output for HP Inkjet Printers and some LaserJets"
HOMEPAGE="http://hpinkjet.sourceforge.net/"
SRC_URI="mirror://sourceforge/hpinkjet/${P}.tar.gz
	http://www.linuxprinting.org/download/foomatic/foomatic-db-hpijs-${DB_V}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="cups foomaticdb ppds"

DEPEND="virtual/ghostscript
	cups? ( net-print/cups )
	net-print/foomatic-filters
	foomaticdb? ( net-print/foomatic-db-engine )"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
	epatch ${FILESDIR}/hpijs-1.4.1-rss.1.patch
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile () {
	econf --disable-cups-install \
		$(use_enable ppds foomatic-install) || die "econf failed"

	sed -i -e 's|/usr/share/cups|${prefix}/share/cups|g' \
		-e 's|/usr/lib/cups|${prefix}/lib/cups|g' \
		-e 's|cp -ax|cp -pPR|g' Makefile \
		|| die "sed failed"

	make || die "make failed"

	if use foomaticdb ; then
		cd ${WORKDIR}/foomatic-db-hpijs-${DB_V}
		econf || die "econf failed"
		rm -fR data-generators/hpijs-rss
		make || die
	fi
}

src_install() {
	einstall || die

	if use cups && use ppds ; then
		dodir /usr/share/cups/model
		dosym /usr/share/ppd /usr/share/cups/model/foomatic-ppds
	fi

	if ! use ppds; then
		rm -fR ${D}/usr/share/ppd
	fi

	use ppds && rm -f ${D}/usr/bin/foomatic-rip

	if use foomaticdb ; then
		cd ../foomatic-db-hpijs-${DB_V}
		make DESTDIR=${D} install || die
	fi
}

pkg_postinst() {
	einfo "To use the hpijs driver with the PDQ spooler you will need the PDQ"
	einfo "driver file for your printer from"
	einfo "http://www.linuxprinting.org/show_driver.cgi?driver=hpijs"
	einfo "This file should be installed in /etc/pdq/drivers"
	einfo
	einfo "The hpijs ebuild no longer creates the ppds automatically, please use"
	einfo "foomatic to do so or remerge hpijs with the ppds use flag."
	echo
	einfo "net-print/hpijs is deprecated, please use net-print/hplip"
	echo
}
