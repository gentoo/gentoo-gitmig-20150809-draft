# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tmpreaper/tmpreaper-1.4.12.ebuild,v 1.18 2004/02/13 00:44:23 ferringb Exp $

MYP="tmpreaper_1.4.12"
S=${WORKDIR}/${P}
DESCRIPTION="A utility for removing files based on when they were last
accessed"
SRC_URI="http://ftp.debian.org/debian/dists/potato/main/source/admin/${MYP}.tar.gz"
HOMEPAGE="http://packages.debian.org/stable/admin/tmpreaper.html"
KEYWORDS="x86 amd64 ppc sparc "
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	make CFLAGS="${CFLAGS}" all || die
}

src_install() {
	dosbin tmpreaper
	doman tmpreaper.8
	dodoc ChangeLog
	#added debian/* files for people who want cron.daily and related files.
	cd debian
	dodoc changelog conffiles copyright cron.daily dirs
}
