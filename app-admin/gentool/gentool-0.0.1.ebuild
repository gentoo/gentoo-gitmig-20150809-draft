# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentool/gentool-0.0.1.ebuild,v 1.2 2001/04/26 03:07:26 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A stand alone webserver written in python actiong as a webinterface to portage"


src_install () {

    exeinto /usr/sbin
    doexe ${FILESDIR}/${PV}/gentool.py
    insinto /usr/share/gentool/images
    doins ${FILESDIR}/gentoo.gif
    exeinto /etc/rc.d/init.d
    doexe ${FILESDIR}/svc-gentool
    exeinto /var/lib/supervise/services/gentool
    newexe ${FILESDIR}/gentool-run run
    dodir /var/log/gentool.d
}

