# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/webconfig/webconfig-0.6.1.ebuild,v 1.1 2002/01/03 19:25:13 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.2

# Note: this supports several programs e.g. cups, wwwoffle... but if some
# aren't installed than the interface for that program simply doesn't work.
# However the error message recieved when trying to activate the interface
# can be very misleading - an http timeout on a local port.

SRC_URI="http://home.tiscalinet.be/psidekick/webconfig/downloads/${PN}-0.6-1.tar.gz
	 http://home.tiscalinet.be/psidekick/webconfig/downloads/${PN}-icons-0.6-1.tar.gz"
S=${WORKDIR}/${PN}-0.6
HOMEPAGE="http://home.tiscalinet.be/psidekick/webconfig/"
DESCRIPTION="A kcontrol interface to various html-based config modules"

newdepend "kde-base/kdebase"

src_install () {

    kde_src_install
    
    cd ${WORKDIR}/share
    dodir ${KDEDIR}/share
    cp -a * ${D}/${KDEDIR}/share

}

