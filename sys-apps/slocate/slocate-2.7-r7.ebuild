# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/slocate/slocate-2.7-r7.ebuild,v 1.1 2004/10/20 16:55:35 swegener Exp $

inherit flag-o-matic eutils

DESCRIPTION="Secure way to index and quickly search for files on your system (drop-in replacement for 'locate')"
HOMEPAGE="http://www.geekreview.org/slocate/"
SRC_URI="ftp://ftp.geekreview.org/slocate/src/slocate-${PV}.tar.gz
	mirror://gentoo/${P}-debian.patch.bz2
	mirror://gentoo/${P}-uclibc-sl_fts.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="uclibc"

DEPEND="sys-apps/shadow"
RDEPEND="sys-apps/shadow"

pkg_setup() {
	enewgroup slocate
}

src_unpack() {
	unpack ${A}
	cd ${S}
	use uclibc && epatch ${WORKDIR}/${P}-uclibc-sl_fts.patch
	epatch ${WORKDIR}/${P}-debian.patch

	append-ldflags -Wl,-z,now
	filter-lfs-flags

	sed -i \
		-e "/groupadd/s/^/#/" \
		-e "/chown.*slocate/s/^/#/" \
		-e "/^CFLAGS/s:-g3:${CFLAGS}:" \
		Makefile.in || die
}

src_install() {
	dodir /usr/share/man/man1
	make DESTDIR="${D}" install || die "make install failed"

	# make install for this package is blocked by sandbox
	dosym slocate /usr/bin/locate
	dosym slocate /usr/bin/updatedb
	fperms 0755 /etc/cron.daily/slocate
	keepdir /var/lib/slocate

	# #37871: nice updatedb
	dosed 's,^\([[:space:]]*\)\(/usr/bin/updatedb\),\1nice \2,' /etc/cron.daily/slocate

	dodoc AUTHORS README ChangeLog

	# man page fixing
	rm -f "${D}/usr/share/man/man1/locate.1.gz"
	dosym slocate.1.gz /usr/share/man/man1/locate.1.gz

	insinto /etc
	doins "${FILESDIR}/updatedb.conf"
	fperms 0644 /etc/updatedb.conf

	fowners root:slocate /usr/bin/slocate
	fperms go-r,g+s /usr/bin/slocate

	chown -R root:slocate "${D}/var/lib/slocate"
	fperms 0750 /var/lib/slocate
}

pkg_postinst() {
	touch "${ROOT}/var/lib/slocate/slocate.db"

	if [[ -f "${ROOT}/etc/cron.daily/slocate.cron" ]]; then
		ewarn
		ewarn "If you merged slocate-2.7.ebuild, please remove"
		ewarn "/etc/cron.daily/slocate.cron since .cron has been removed"
		ewarn "from the filename"
		ewarn
		echo
	fi
	einfo "Note that the /etc/updatedb.conf file is generic"
	einfo "Please customize it to your system requirements"
}
