# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tmpreaper/tmpreaper-1.4.12.ebuild,v 1.8 2002/07/21 21:13:09 gerk Exp $


MYP="tmpreaper_1.4.12"
S=${WORKDIR}/${P}
DESCRIPTION="A utility for removing files based on when they were last
accessed"
SRC_URI="http://ftp.debian.org/debian/dists/potato/main/source/admin/${MYP}.tar.gz"
HOMEPAGE="http://packages.debian.org/stable/admin/tmpreaper.html"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {

   try make CFLAGS="${CFLAGS}" all

}

src_install () {

   dosbin tmpreaper
   doman tmpreaper.8
   dodoc ChangeLog 
   #added debian/* files for people who want cron.daily and related files.
   cd debian
   dodoc changelog conffiles copyright cron.daily dirs

}
