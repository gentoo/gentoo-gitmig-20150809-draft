# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/noweb/noweb-2.9-r2.ebuild,v 1.4 2002/08/01 11:40:14 seemant Exp $

S=${WORKDIR}/src
#SRC_URI="ftp://ftp.dante.de/tex-archive/web/noweb/src.tar.gz"
SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/noweb-src-${PV}.tar.gz"

HOMEPAGE="http://www.eecs.harvard.edu/~nr/noweb/"
DESCRIPTION="a literate programming tool, lighter than web"

DEPEND="sys-devel/gcc
	app-text/tetex
	sys-apps/gawk"
KEYWORDS="x86 ppc"
src_unpack() {
    
    unpack ${A}
    cd ${S}
    patch -p0 <${FILESDIR}/${PF}-gentoo.diff || die
    
}

src_compile() {
    
    emake || die

}

src_install () {

    make DESTDIR=${D} install || die
    
    [ -x /usr/bin/nawk ] || dosym /usr/bin/gawk /usr/bin/nawk

	# fix man pages to be LFH compliant
	mv ${D}/usr/man ${D}/usr/share

}

pkg_postinst() {

    einfo "Running texhash to complete installation.."
    addwrite "/var/lib/texmf"
    addwrite "/usr/share/texmf"
    addwrite "/var/cache/fonts"
    texhash
}
