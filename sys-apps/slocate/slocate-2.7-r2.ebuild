# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/slocate/slocate-2.7-r2.ebuild,v 1.3 2003/05/06 14:25:19 gmsoft Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Secure locate provides a secure way to index and quickly search for files on your system (drop-in replacement for 'locate')"
HOMEPAGE="http://www.geekreview.org/slocate/"
SRC_URI="ftp://ftp.geekreview.org/slocate/src/slocate-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha hppa ~mips"

DEPEND="sys-apps/shadow"

src_install() {

	dodir /usr/share/man/man1

	sed -i -e "/groupadd/s/^/#/;/chown.*slocate/s/^/#/" Makefile || die
	make DESTDIR=${D} install || die

	# make install for this package is blocked by sandbox
	dosym slocate /usr/bin/locate
	dosym slocate /usr/bin/updatedb
	fperms 0755 /etc/cron.daily/slocate
	keepdir /var/lib/slocate

	# If this file doesn't exist, the first run of updatedb will create
	# it anyway.  But doing this shuts it up.
	if [ ! -f ${ROOT}/var/lib/slocate/slocate.db ] ; then
		touch ${D}/var/lib/slocate/slocate.db
	fi

	dodoc INSTALL LICENSE COPYING AUTHORS NEWS README ChangeLog

	# man page fixing
	rm -rf ${D}/usr/share/man/man1/locate.1.gz
	dosym slocate.1.gz /usr/share/man/man1/locate.1.gz


	insinto /etc
	doins ${FILESDIR}/updatedb.conf
	fperms 0644 /etc/updatedb.conf
}

pkg_postinst() {
	touch /var/lib/slocate/slocate.db

	# /var/lib/slocate is owned by group slocate and so is the executable
	if ! groupmod slocate; then
		groupadd slocate 2> /dev/null || die "Failed to create slocate group"
	fi

	chown root.slocate /usr/bin/slocate
	chmod 2755 /usr/bin/slocate

	chown -R root.slocate /var/lib/slocate
	chmod 0750 /var/lib/slocate

	ewarn "If you merged slocate-2.7.ebuild, please remove"
	ewarn "/etc/cron.daily/slocate.cron the .cron is no longer"
	ewarn "in the filename"
	echo
	einfo "Note that the /etc/updatedb.conf file is generic"
	einfo "Please customize it to your system requirements"
}
