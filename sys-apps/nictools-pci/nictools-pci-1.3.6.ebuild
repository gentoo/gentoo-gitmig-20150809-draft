# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nictools-pci/nictools-pci-1.3.6.ebuild,v 1.1 2003/07/12 18:15:24 lisa Exp $


DESCRIPTION="Nictools-PCI, diagnostic tools for a variety of PCI nics"


HOMEPAGE="http://www.scyld.com/diag/index.html"

SRC_URI="ftp://ftp.debian.org/debian/pool/main/n/nictools-pci/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=""

#RDEPEND=""

S=${WORKDIR}/${P}.orig  # Fix source dir

src_compile() {
	# Since this tarball is just a bunch of .c files, I'll compile them
	cd ${S}

	einfo "Compiling alta-diag"
	${CC} ${CFLAGS} -O -Wall -Wstrict-prototypes -o alta-diag alta-diag.c -DLIBFLASH libflash.c -DLIBMII libmii.c || die "Failed to build alta-diag"

	einfo "Compiling eepro100-diag"
	${CC} ${CFLAGS} -O -Wall -o eepro100-diag eepro100-diag.c -DLIBMII libmii.c || die "Failed to build eepro100-diag"

	einfo "Compiling epic-diag"
	${CC} ${CFLAGS} -O -Wall -o epic-diag epic-diag.c -DLIBMII libmii.c -DLIBFLASH libflash.c || die "Failed to build epic-diag"

	einfo "Compiling myson-diag"
	${CC} ${CFLAGS} -O -Wall -Wstrict-prototypes -o myson-diag myson-diag.c `[ -f libmii.c ] && echo -DLIBMII libmii.c` `[ -f libmii.c ] && echo -DLIBFLASH libflash.c` || die "Failed to build myson-diag"

	einfo "Compiling natsemi-diag"
	${CC} ${CFLAGS} -O -Wall -o natsemi-diag natsemi-diag.c || die "Failed to build natsemi-diag"

	einfo "Compiling ne2k-diag"
	${CC} ${CFLAGS} -O6 -Wall -o ne2k-diag ne2k-diag.c || die "Failed to build ne2k-diag"

	einfo "Compiling ns820-diag"
	${CC} ${CFLAGS} -O -Wall -Wstrict-prototypes -o ns820-diag ns820-diag.c `[ -f libmii.c ] && echo -DLIBMII libmii.c` `[ -f libmii.c ] && echo -DLIBFLASH libflash.c`  || die "Failed to build ns820-diag"

	einfo "Compiling pcnet-diag"
	${CC} ${CFLAGS} -O -Wall -Wstrict-prototypes -o pcnet-diag pcnet-diag.c `[ -f libmii.c ] && echo -DLIBMII libmii.c`  || die "Failed to build pcnet-diag"

	einfo "Compiling rt8139-diag"
	${CC} ${CFLAGS} -O -Wall -o rtl8139-diag rtl8139-diag.c `[ -f libmii.c ] && echo -DLIBMII libmii.c` || die "Failed to build rt8139-diag"

	einfo "Compiling starfire-diag"
	${CC} ${CFLAGS} -O -Wall -o starfire-diag starfire-diag.c  || die "Failed to build starfire-diag"

	einfo "Compiling tulip-diag"
	${CC} ${CFLAGS} -O -Wall -Wstrict-prototypes -o tulip-diag tulip-diag.c `[ -f libmii.c ] && echo -DLIBMII libmii.c` `[ -f libflash.c ] && echo -DLIBFLASH libflash.c`  || die "Failed to build tulip-diag"

	einfo "Compiling via-diag"
	${CC} ${CFLAGS} -O -Wall -o via-diag via-diag.c  || die "Failed to build via-diag"

	einfo "Compiling vortex-diag"
	${CC} ${CFLAGS} -O -Wall -o vortex-diag vortex-diag.c -DLIBMII libmii.c  -DLIBFLASH libflash.c || die "Failed to build vortex-diag"

	einfo "Compiling winbond-diag"
	${CC} ${CFLAGS} -O -Wall -Wstrict-prototypes -o winbond-diag winbond-diag.c `[ -f libmii.c ] && echo -DLIBMII libmii.c` `[ -f libmii.c ] && echo -DLIBFLASH libflash.c`  || die "Failed to build winbond-diag"

	einfo "compiling yellowfin-diag"
	${CC} ${CFLAGS} -O -Wall -Wstrict-prototypes -o yellowfin-diag yellowfin-diag.c `[ -f libmii.c ] && echo -DLIBMII libmii.c` `[ -f libmii.c ] && echo -DLIBFLASH libflash.c`  || die "Failed to build yellow-fin-diag"
}

src_install() {
	dobin alta-diag
	dobin eepro100-diag
	dobin epic-diag
	dobin myson-diag
	dobin natsemi-diag
	dobin ne2k-diag
	dobin ns820-diag
	dobin pcnet-diag
	dobin rtl8139-diag
	dobin starfire-diag
	dobin tulip-diag
	dobin via-diag
	dobin vortex-diag
	dobin winbond-diag
	dobin yellowfin-diag
}

