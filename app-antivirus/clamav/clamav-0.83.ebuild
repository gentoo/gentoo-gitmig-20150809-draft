# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/clamav/clamav-0.83.ebuild,v 1.8 2005/03/27 00:33:12 hansmi Exp $

inherit eutils flag-o-matic

DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://www.clamav.net/"
SRC_URI="mirror://sourceforge/clamav/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64 hppa alpha ~ppc64"
IUSE="crypt milter selinux"

DEPEND="virtual/libc
	crypt? ( >=dev-libs/gmp-4.1.2 )
	milter? ( mail-mta/sendmail )
	>=sys-libs/zlib-1.2.1-r3
	>=net-misc/curl-7.10.0
	net-dns/libidn"
RDEPEND="selinux? ( sec-policy/selinux-clamav )"
PROVIDE="virtual/antivirus"

#S="${WORKDIR}/${P/_/}"

pkg_setup() {
	if use milter; then
		if ! built_with_use mail-mta/sendmail milter; then
			ewarn "In order to enable milter support, clamav needs sendmail with enabled milter"
			ewarn "USE flag. Either recompile sendmail with milter USE flag enabled, or disable"
			ewarn "this flag for clamav as well to disable milter support."
			die "need milter-enabled sendmail"
		fi
	fi
	enewgroup clamav
	enewuser clamav -1 /bin/false /dev/null clamav
	pwconv || die
}

src_compile() {
	has_version =sys-libs/glibc-2.2* && filter-lfs-flags

	local myconf

	# we depend on fixed zlib, so we can disable this check to prevent redundant
	# warning (bug #61749)
	myconf="${myconf} --disable-zlib-vcheck"

	use milter && myconf="${myconf} --enable-milter"
	econf ${myconf} --with-dbdir=/var/lib/clamav || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README ChangeLog TODO FAQ INSTALL
	exeinto /etc/init.d ; newexe ${FILESDIR}/clamd.rc clamd
	insinto /etc/conf.d ; newins ${FILESDIR}/clamd.conf clamd
	dodoc ${FILESDIR}/clamav-milter.README.gentoo
}

pkg_postinst() {
	echo
	einfo "NOTE: As of clamav-0.80, the config file for clamd is no longer"
	einfo "      /etc/clamav.conf, but /etc/clamd.conf. Adjust your"
	einfo "      configuration accordingly before (re)starting clamd."
	echo
	ewarn "Warning: clamd and/or freshclam have not been restarted."
	ewarn "You should restart them with: /etc/init.d/clamd restart"
	echo
	if use milter ; then
		einfo "For simple instructions howto setup the clamav-milter..."
		einfo ""
		einfo "less /usr/share/doc/${PF}/clamav-milter.README.gentoo.gz"
		echo
	fi
}
