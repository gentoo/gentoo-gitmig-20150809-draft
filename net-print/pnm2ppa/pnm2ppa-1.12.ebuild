# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pnm2ppa/pnm2ppa-1.12.ebuild,v 1.7 2004/04/09 13:02:34 lanius Exp $

# Note: this also d/ls the hp-ppa-howto and installs it under /usr/share/doc/${P}

SRC_URI="mirror://sourceforge/pnm2ppa/${P}.tar.gz
	 mirror://sourceforge/pnm2ppa/howto.tgz"

HOMEPAGE="http://pnm2ppa.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
DESCRIPTION="Print driver for Hp Deskjet 710, 712, 720, 722, 820, 1000 series"
LICENSE="GPL-2"

# note: this doesn't depend on virtual/lpr, because it can work on its own,
# just without queueing etc. since it's not just a driver but a standalone
# executable.
DEPEND="gtk? ( x11-libs/gtk+ )
	ncurses? ( sys-libs/ncurses )"

RDEPEND="${DEPEND}
	app-text/enscript
	dev-util/dialog"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack howto.tgz

	patch -l -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	export CFLAGS="-DNDEBUG ${CFLAGS}"

	emake CFLAGS="${CFLAGS} -DLANG_EN" || die

	cd ${S}/ppa_protocol
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dodir /usr/bin
	dodir /etc
	dodir /usr/share/man/man1

	make	\
		BINDIR=${D}/usr/bin	\
		CONFDIR=${D}/etc	\
		MANDIR=${D}/usr/share/man/man1	\
		install || die

	exeinto /usr/bin
	doexe utils/Linux/detect_ppa utils/Linux/test_ppa

	insinto /usr/share/pnm2ppa/lpd
	doins ${S}/lpd/*
	exeinto /usr/share/pnm2ppa/lpd
	doexe ${S}/lpd/lpdsetup

	insinto /usr/share/pnm2ppa/pdq
	doins ${S}/pdq/*

	# Interfaces for configuration of integration with lpd
	# These are not installed because we do not assume that
	# lpd, ncurses, gtk, but the sources are provided.  Thus,
	# if the headers were found they would have been built.

	exeinto /usr/share/pnm2ppa/sample_scripts
	doexe ${S}/sample_scripts/*

	cd ${S}/pdq
	exeinto /etc/pdq/drivers/ghostscript
	doexe gs-pnm2ppa
	exeinto /etc/pdq/interfaces
	doexe dummy

	# possibly not needed
	#rm ${D}/etc/printcap.*

	cd ${S}/docs/en
	dodoc CALIBRATION*txt COLOR*txt PPA*txt RELEASE*
	dodoc CREDITS INSTALL LICENSE README TODO

	cd sgml
	insinto /usr/share/doc/${P}
	doins *.sgml

	cd ${S}
	dohtml -r .

}

pkg_postinst() {
	einfo "Now, you *must* edit /etc/pnm2ppa.conf and choose (at least)"
	einfo "your printer model and papersize."
	einfo ""
	einfo "Run calibrate_ppa to calibrate color offsets."
	einfo ""
	einfo "Read the docs in /usr/share/pnm2ppa/ to configure the printer,"
	einfo "configure lpr substitutes, cups, pdq, networking etc."
	einfo ""
	einfo "Note that lpr and pdq drivers *have* been installed, but if your"
	einfo "config file management has /etc blocked (the default), they have"
	einfo "been installed under different filenames. Read the appropriate"
	einfo "Gentoo documentation for more info."
	einfo ""
	einfo "Note: lpr has been configured for default papersize letter"
}

