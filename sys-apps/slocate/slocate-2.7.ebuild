# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/slocate/slocate-2.7.ebuild,v 1.6 2003/04/12 16:22:11 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Secure locate provides a secure way to index and quickly search for files on your system (drop-in replacement for 'locate')"
HOMEPAGE="http://www.geekreview.org/slocate/"
SRC_URI="ftp://ftp.geekreview.org/slocate/src/slocate-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha ~hppa ~mips"

DEPEND="virtual/glibc"

src_install() {

	dodir /usr/share/man/man1

	make DESTDIR=${D} install || die

	# make install for this package is blocked by sandbox
#	dobin slocate
	dosym slocate /usr/bin/locate
	dosym slocate /usr/bin/updatedb
	fperms 0755 /etc/cron.daily/slocate.cron
#
#	dosym slocate.1.gz /usr/share/man/man1/locate.1.gz
#
	dodir /var/lib/slocate ; touch ${D}/var/lib/slocate/.keep

	touch ${D}/etc/updatedb.conf

	dodoc INSTALL LICENSE COPYING AUTHORS NEWS README ChangeLog


	# man page fixing
	rm -rf ${D}/usr/share/man/man1/locate.1.gz
	dosym slocate.1.gz /usr/share/man/man1/locate.1.gz

	echo "# There is a sample config file in :" > updatedb.conf
	echo "# /usr/share/doc/${P}/updatedb.conf.gz" >> updatedb.conf
	insinto /etc
	doins updatedb.conf
	fperms 0644 /etc/updatedb.conf

	dodoc ${FILESDIR}/updatedb.conf
}

pkg_postinst() {
	# /var/lib/slocate is owned by group slocate and so is the executable
	groupadd slocate

	chown root.slocate /usr/bin/slocate
	chmod 2755 /usr/bin/slocate

	chown root.slocate /var/lib/slocate
	chmod 0750 /var/lib/slocate

	einfo "Please note that the /etc/updatedb.conf file is EMPTY"
	einfo "There is a sample configuration file in"
	einfo "/usr/share/doc/${P}"
}
