# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-print/pnm2ppa/pnm2ppa-1.0.91.ebuild,v 1.7 2002/07/14 20:41:22 aliz Exp $
# Note: this also d/ls the hp-ppa-howto and installs it under /usr/share/doc/${P}

# pnm2ppa is a print filter for HP's line of Winprinters which use a proprietary
# protocol called ppa (Print Performance Architecture). Like Winmodems, Winprinters
# don't have a microprocessor; your main CPU does all the hard work.
# Winprinters: Hp Deskjet 710, 712, 720, 722, 820, 1000 series.
# pnm2ppa can work on its own or via lpr or pdq.

# The ebuild in general seems a bit flaky, anyone who has a ppa printer
# please check it out and tell me if it worked.

# Description of accompanying patch: install into /usr instead of /usr/local
# and use env. var. CFLAGS. Took a lot of changes though.

S=${WORKDIR}/pnm2ppa
SRC_URI="mirror://sourceforge/pnm2ppa/${P}.tgz
	 mirror://sourceforge/pnm2ppa/howto.tgz"

HOMEPAGE="http://pnm2ppa.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
DESCRIPTION="Print driver for Hp Deskjet 710, 712, 720, 722, 820, 1000 series"
LICENSE="GPL-2"

# note: this doesn't depend on virtual/lpr, because it can work on its own,
# just without queueing etc. since it's not just a driver but a standalone
# executable.
DEPEND="sys-libs/glibc sys-devel/ld.so"
RDEPEND="sys-libs/glibc sys-devel/ld.so app-text/enscript"

src_unpack() {
    
    cd ${WORKDIR}
    unpack ${P}.tgz
    cd ${S}
    unpack howto.tgz
    
}

src_compile() {
    
    # there is no configure, so we patch various makefiles
    # to intall into /usr and to include $CFLAGS optimization
    cd ${WORKDIR}
    patch -p0 <${FILESDIR}/${P}-gentoo.diff

    cd ${S}
    try emake
    
    cd ${S}/ppa_protocol
    try emake
    
#    cd ${S}/ppaSet-beta1
#    # This requires gtk, ncurses etc. on which we don't want to depend
#    # so we simply fail if they aren't installed
#    echo "The following may fail, don't pay attention to any error"
#    sleep 1s
#    emake gPpaSet 
#    emake nPpaSet
#    emake

}

src_install () {

    # There are problems with the builtin make install.
    
    cd ${S}
    
    into /usr
    dobin pnm2ppa calibrate_ppa
    doman docs/en/pnm2ppa.1
    
    insinto /etc
    doins pnm2ppa.conf
    
    # Install docs, filtering out distro-specific install documents
    # Note: we don't use dodoc but rather doins because html/sgml/lyx docs
    # shouldn't be gzipped IMHO
    cd docs/en
    insinto /usr/share/doc/${P}
    doins CALIBRATION.* COLOR.* CREDITS INSTALL LICENSE PPA* README RELEASE-NOTES TODO
    cd sgml
    insinto /usr/share/doc/${P}/sgml
    doins CALIBRATION.sgml COLOR.sgml PPA*
    cd ${S}/howto
    insinto /usr/share/doc/${P}/howto/
    doins *
    
    cd ${S}/ppa_protocol
    dobin parse_vlink
    insinto /usr/share/doc/${P}/ppa_protocol/
    doins *.html
    
    cd ${S}/utils/Linux
    dobin detect_ppa test_ppa
    
    # Install various things into /usr/share/pnm2ppa
    dodir /usr/share/pnm2ppa
    cd ${D}/usr/share/pnm2ppa
    
    ln -s ../doc/${P} ./doc

    insinto /usr/share/pnm2ppa/lpd
    doins ${S}/lpd/*
    exeinto /usr/share/pnm2ppa/lpd
    doexe ${S}/lpd/lpdsetup

    insinto /usr/share/pnm2ppa/pdq
    doins ${S}/pdq/*
    
    # Interfaces for configuration of integration with lpd.
    # We don't install them because we don't want to depend on lpd.
    # ncurses, gtk (the interface libs) but we provide the source
    # for the user. If gtk/ncurses headers are installed, they will
    # have been built.
    dodir /usr/share/pnm2ppa/ppaSet-beta1/dialog
    insinto /usr/share/pnm2ppa/ppaSet-beta1
    doins ${S}/ppaSet-beta1/*
    insinto /usr/share/pnm2ppa/ppaSet-beta1/dialog
    doins ${S}/ppaSet-beta1/dialog/*
    exeinto /usr/share/pnm2ppa/ppaSet-beta1
    cd ${S}/ppaSet-beta1
    doexe calibration cleanHeads gammaRef install noGamma ppa.if test
    
    dodir /usr/share/pnm2ppa/sample_scripts
    exeinto /usr/share/pnm2ppa/sample_scripts
    doexe ${S}/sample_scripts/*

    dodir /usr/share/pnm2ppa/testpages
    insinto /usr/share/pnm2ppa/testpages
    doins ${S}/testpages/*
    
    # Install lpr filters: add them to the end of the existing printcap.
    # We have /etc protection as default, so it's safe, but easier to
    # setup later.
    dodir /etc
    cp /etc/printcap ${D}/etc/printcap.current
    cp ${S}/lpd/printcap ${D}/etc/printcap.new
    cat ${D}/etc/printcap.current ${D}/etc/printcap.new > ${D}/etc/printcap
    rm ${D}/etc/printcap.*
    # run provided script (I patched it), it needs its dir as pwd
    cd ${S}/lpd
    DESTDIR=${D} ./lpdsetup
    
    # Install pdq filters, need to be activated via configuration via xpdq
    cd ${S}/pdq
    exeinto /etc/pdq/drivers/ghostscript
    doexe gs-pnm2ppa
    exeinto /etc/pdq/interfaces
    doexe dummy    
    
}

pkg_postinst() {

    echo "
    Now, you *must* edit /etc/pnm2ppa.conf and choose (at least)
    your printer model and papersize.
    
    Run calibrate_ppa to calibrate color offsets.
    
    Read the docs in /usr/share/pnm2ppa/ to configure the printer,
    configure lpr substitutes, cups, pdq, networking etc.
    
    Note that lpr and pdq drivers *have* been installed, but if your
    config file management has /etc blocked (the default), they have
    been installed under different filenames. Read the appropriate
    Gentoo documentation for more info.
    
    Note: lpr has been configured for default papersize letter
    "
    
}
