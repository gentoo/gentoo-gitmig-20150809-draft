# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/slocate/slocate-2.6.ebuild,v 1.3 2002/07/14 19:20:19 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Secure locate provides a secure way to index and quickly search for files on your system (drop-in replacement for 'locate')"
SRC_URI="ftp://ftp.geekreview.org/slocate/src/slocate-${PV}.tar.gz"
HOMEPAGE="http://www.geekreview.org/slocate/"
KEYWORDS="x86"
SLOT="0"
DEPEND="virtual/glibc"
LICENSE="GPL-2"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	emake || die
}


src_install() {

	# make install for this package is blocked by sandbox
	dobin slocate
	dosym /usr/bin/slocate /usr/bin/locate
	dosym /usr/bin/slocate /usr/bin/updatedb

	dodir /var/lib/slocate ; touch ${D}/var/lib/slocate/.keep

	insinto /etc/cron.daily
	chmod +x slocate.cron
	doins slocate.cron

	# man pages are already compressed for us
	insinto /usr/share/man/man1
	mv doc/slocate.1.linux.gz doc/slocate.1.gz
	doins doc/slocate.1.gz doc/updatedb.1.gz
	dosym /usr/share/man/man1/slocate.1.gz /usr/share/man/man1/locate.1.gz

	dodoc LICENSE COPYING AUTHORS NEWS README ChangeLog
}

pkg_postinst() {
	# /var/lib/slocate is owned by group slocate and so is the executable
	groupadd slocate

	chown root.slocate /usr/bin/slocate
	chmod 2755 /usr/bin/slocate

	chown root.slocate /var/lib/slocate
	chmod 0750 /var/lib/slocate
}
