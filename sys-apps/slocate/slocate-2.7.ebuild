# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/slocate/slocate-2.7.ebuild,v 1.5 2003/04/12 15:47:54 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Secure locate provides a secure way to index and quickly search for files on your system (drop-in replacement for 'locate')"
HOMEPAGE="http://www.geekreview.org/slocate/"
SRC_URI="ftp://ftp.geekreview.org/slocate/src/slocate-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha ~hppa ~mips"

DEPEND="virtual/glibc"

src_install() {
	# make install for this package is blocked by sandbox
	dobin slocate
	dosym /usr/bin/slocate /usr/bin/locate
	dosym /usr/bin/slocate /usr/bin/updatedb

	dodir /var/lib/slocate ; touch ${D}/var/lib/slocate/.keep

	insinto /etc/cron.daily
        doins slocate.cron
        fperms 0755 /etc/cron.daily/slocate.cron

	# man pages are already compressed for us
	insinto /usr/share/man/man1
	mv doc/slocate.1.linux.gz doc/slocate.1.gz
	doins doc/slocate.1.gz doc/updatedb.1.gz
	dosym /usr/share/man/man1/slocate.1.gz /usr/share/man/man1/locate.1.gz

	dodoc INSTALL LICENSE COPYING AUTHORS NEWS README ChangeLog
	dodoc ${FILESDIR}/updatedb.conf
	einfo ""
	einfo "You can find a sample config file in"
	einfo "/usr/share/doc/${P}/updatedb.conf.gz"
	einfo ""
}

pkg_postinst() {
	# /var/lib/slocate is owned by group slocate and so is the executable
	groupadd slocate

	chown root.slocate /usr/bin/slocate
	chmod 2755 /usr/bin/slocate

	chown root.slocate /var/lib/slocate
	chmod 0750 /var/lib/slocate
}
