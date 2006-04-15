# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/slocate/slocate-2.7-r8.ebuild,v 1.7 2006/04/15 20:08:41 nixnut Exp $

inherit flag-o-matic eutils

DESCRIPTION="Secure way to index and quickly search for files on your system (drop-in replacement for 'locate')"
HOMEPAGE="http://www.geekreview.org/slocate/"
SRC_URI="ftp://ftp.geekreview.org/slocate/src/slocate-${PV}.tar.gz
	mirror://gentoo/${P}-debian.patch.bz2
	elibc_uclibc? ( mirror://gentoo/${P}-uclibc-sl_fts.patch.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh ~sparc ~x86"
IUSE=""

DEPEND="sys-apps/shadow"
RDEPEND="${DEPEND}
	!sys-apps/rlocate"

pkg_setup() {
	if [[ -n $(egetent group slocate) ]] ; then
		eerror "The 'slocate' group has been renamed to 'locate'."
		eerror "You seem to already have a 'slocate' group."
		eerror "Please rename it:"
		eerror "groupmod -n locate slocate"
		die "Change 'slocate' to 'locate'"
	fi
	enewgroup locate 245
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	use elibc_uclibc && epatch "${WORKDIR}"/${P}-uclibc-sl_fts.patch
	epatch "${WORKDIR}"/${P}-debian.patch
	epatch "${FILESDIR}"/${P}-bounds.patch
	epatch "${FILESDIR}"/${P}-really-long-paths.patch

	sed -i \
		-e '/SLOC_GRP/s:slocate:locate:' \
		main.c || die "sed group"

	filter-lfs-flags
	# this is safe since slocate only has 1 binary
	append-ldflags $(bindnow-flags)

	sed -i \
		-e "/groupadd/s/^/#/" \
		-e "/chown.*slocate/s/^/#/" \
		-e '/^CFLAGS/d' \
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
	rm -f "${D}"/usr/share/man/man1/locate.1.gz
	dosym slocate.1.gz /usr/share/man/man1/locate.1.gz

	insinto /etc
	doins "${FILESDIR}/updatedb.conf"
	fperms 0644 /etc/updatedb.conf

	fowners root:locate /usr/bin/slocate
	fperms go-r,g+s /usr/bin/slocate

	chown -R root:locate "${D}/var/lib/slocate"
	fperms 0750 /var/lib/slocate
}

pkg_postinst() {
	touch "${ROOT}/var/lib/slocate/slocate.db"

	if [[ -f ${ROOT}/etc/cron.daily/slocate.cron ]]; then
		ewarn "If you merged slocate-2.7.ebuild, please remove"
		ewarn "/etc/cron.daily/slocate.cron since .cron has been removed"
		ewarn "from the filename"
		echo
	fi
	einfo "Note that the /etc/updatedb.conf file is generic"
	einfo "Please customize it to your system requirements"
}
