# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/va-systemimager-client/va-systemimager-client-1.4.0.ebuild,v 1.4 2002/07/11 06:30:09 drobbins Exp $


S=${WORKDIR}/${P}
DESCRIPTION="VA SystemImager software automates the installation of Linux to masses of similar machines."
SRC_URI="http://download.sourceforge.net/systemimager/${P}.tar.bz2"
HOMEPAGE="http://systemimager.org"
LICENSE="GPL-2"

src_install () {


    try DESTDIR=${D} ./installclient --quiet


}

