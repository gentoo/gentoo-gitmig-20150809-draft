# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/slocate/slocate-2.7-r5.ebuild,v 1.16 2004/07/27 08:47:30 mr_bones_ Exp $

inherit flag-o-matic eutils

DESCRIPTION="Secure way to index and quickly search for files on your system (drop-in replacement for 'locate')"
HOMEPAGE="http://www.geekreview.org/slocate/"
SRC_URI="ftp://ftp.geekreview.org/slocate/src/slocate-${PV}.tar.gz
	mirror://gentoo/slocate-${PV}-uclibc-sl_fts.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="uclibc"

DEPEND="sys-apps/shadow
	>=sys-apps/sed-4
	sys-devel/automake"
RDEPEND="sys-apps/shadow"

src_unpack() {
	unpack ${A}
	use uclibc && epatch ${DISTDIR}/slocate-${PV}-uclibc-sl_fts.patch
}

src_compile() {
	filter-lfs-flags
	econf || die
	emake || die
}

src_install() {
	dodir /usr/share/man/man1

	sed -i -e "/groupadd/s/^/#/;/chown.*slocate/s/^/#/" Makefile || die
	make DESTDIR="${D}" install || die "make install failed"

	# make install for this package is blocked by sandbox
	dosym slocate /usr/bin/locate
	dosym slocate /usr/bin/updatedb
	fperms 0755 /etc/cron.daily/slocate
	keepdir /var/lib/slocate

	# fix bug 37354: nice updatedb
	sed -i -e 's,^\([[:space:]]*\)\(/usr/bin/updatedb\),\1nice \2,' \
		"${D}/etc/cron.daily/slocate" \
		|| die "sed ${D}/etc/cron.daily/slocate failed"

	dodoc AUTHORS README ChangeLog

	# man page fixing
	rm -f "${D}/usr/share/man/man1/locate.1.gz"
	dosym slocate.1.gz /usr/share/man/man1/locate.1.gz

	insinto /etc
	doins "${FILESDIR}/updatedb.conf"
	fperms 0644 /etc/updatedb.conf
}

pkg_postinst() {
	touch "${ROOT}/var/lib/slocate/slocate.db"

	# /var/lib/slocate is owned by group slocate and so is the executable
	if ! groupmod slocate; then
		groupadd slocate 2> /dev/null || die "Failed to create slocate group"
	fi

	chown root:slocate "${ROOT}/usr/bin/slocate"

	# If nobody else minds I'd like to see 2711 become the system wide default.
	# -solar
	if has sfperms ${FEATURES}; then
		chmod 2711 "${ROOT}/usr/bin/slocate"
	else
		chmod 2755 "${ROOT}/usr/bin/slocate"
	fi

	chown -R root:slocate "${ROOT}/var/lib/slocate"
	chmod 0750 "${ROOT}/var/lib/slocate"

	if [[ -f "${ROOT}/etc/cron.daily/slocate.cron" ]]; then
		ewarn
		ewarn "If you merged slocate-2.7.ebuild, please remove"
		ewarn "/etc/cron.daily/slocate.cron since .cron has been removed"
		ewarn "from the filename"
		ewarn
		echo
	fi
	einfo
	einfo "Note that the /etc/updatedb.conf file is generic"
	einfo "Please customize it to your system requirements"
	einfo
}
