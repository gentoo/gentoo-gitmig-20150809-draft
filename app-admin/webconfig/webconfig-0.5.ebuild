# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/webconfig/webconfig-0.5.ebuild,v 1.2 2001/08/04 17:48:23 danarmak Exp $

# Note: this supports several programs e.g. cups, wwwoffle... but if some
# aren't installed than the interface for that program simply doesn't work.
# However the error message recieved when trying to activate the interface
# can be very misleading - an http timeout on a localo port.

S=${WORKDIR}/${P}
SRC_URI="http://home.tiscalinet.be/psidekick/webconfig/downloads/${P}.tar.gz
	 http://home.tiscalinet.be/psidekick/webconfig/downloads/webconfig-icons-${PV}.tar.gz"

HOMEPAGE="http://home.tiscalinet.be/psidekick/webconfig/"
DESCRIPTION="A kcontrol interface to various html-based config modules"

# Links against tons of libs, through khtml?
# It may not need all these absolutely, but kde itself does
# I'm sure it can install wherever kdebase (with kcontrol + konqueror)
# is installed. Otherwise I'd get a list like this:
#DEPEND="kde-base/kdebase
#	virtual/x11
#	x11-libs/qt
#	media-libs/libpng
#	sys-libs/libz
#	media-libs/jpeg
#	sys-devel/gcc
#	sys-libs/glibc
#	virtual/glut
#	media-libs/libmng
#	sys-devel/ld.so
#	dev-libs/openssl
#	media-libs/freetype
#	media-libs/lcms"
DEPEND="kde-base/kdebase"

src_compile() {
    
    try ./configure 
    
    try emake

}

src_install () {

    try make DESTDIR=${D} install
    
    cd ${WORKDIR}/share
    dodir ${KDEDIR}/share
    cp -a * ${D}/${KDEDIR}/share

}

