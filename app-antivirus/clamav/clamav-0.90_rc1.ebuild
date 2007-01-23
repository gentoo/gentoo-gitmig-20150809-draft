# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/clamav/clamav-0.90_rc1.ebuild,v 1.5 2007/01/23 15:22:40 genone Exp $

inherit eutils flag-o-matic fixheadtails

MY_P="${P/_rc1/RC1.1}"
DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://www.clamav.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt milter selinux mailwrapper"

DEPEND="virtual/libc
	crypt? ( >=dev-libs/gmp-4.1.2 )
	milter? ( || ( mail-filter/libmilter mail-mta/sendmail ) )
	>=sys-libs/zlib-1.2.1-r3
	>=net-misc/curl-7.10.0
	>=sys-apps/sed-4"
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-clamav )
	sys-apps/grep"
PROVIDE="virtual/antivirus"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use milter; then
		if [ ! -e /usr/lib/libmilter.a ] ; then
			ewarn "In order to enable milter support, clamav needs sendmail with enabled milter"
			ewarn "USE flag. Either recompile sendmail with milter USE flag enabled, or disable"
			ewarn "this flag for clamav as well to disable milter support."
			die "need milter-enabled sendmail"
		fi
	fi
	enewgroup clamav
	enewuser clamav -1 -1 /dev/null clamav
}

src_compile() {
	has_version =sys-libs/glibc-2.2* && filter-lfs-flags

	local myconf

	# we depend on fixed zlib, so we can disable this check to prevent redundant
	# warning (bug #61749)
	myconf="${myconf} --disable-zlib-vcheck"
	# use id utility instead of /etc/passwd parsing (bug #72540)
	myconf="${myconf} --enable-id-check"
	use milter && {
		myconf="${myconf} --enable-milter"
		use mailwrapper && \
			myconf="${myconf} --with-sendmail=/usr/sbin/sendmail.sendmail"
	}

	ht_fix_file configure
	econf ${myconf} \
		--enable-experimental \
		--with-dbdir=/var/lib/clamav || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README ChangeLog FAQ INSTALL
	newconfd ${FILESDIR}/clamd.conf clamd
	newinitd ${FILESDIR}/clamd.rc clamd
	dodoc ${FILESDIR}/clamav-milter.README.gentoo

	dodir /var/run/clamav
	keepdir /var/run/clamav
	fowners clamav:clamav /var/run/clamav
	dodir /var/log/clamav
	keepdir /var/log/clamav
	fowners clamav:clamav /var/log/clamav

	# Change /etc/clamd.conf to be usable out of the box
	sed -i -e "s:^\(Example\):\# \1:" \
		-e "s:.*\(PidFile\) .*:\1 /var/run/clamav/clamd.pid:" \
		-e "s:.*\(LocalSocket\) .*:\1 /var/run/clamav/clamd.sock:" \
		-e "s:.*\(User\) .*:\1 clamav:" \
		-e "s:^\#\(LogFile\) .*:\1 /var/log/clamav/clamd.log:" \
		-e "s:^\#\(LogTime\).*:\1 yes:" \
		${D}/etc/clamd.conf

	# Do the same for /etc/freshclam.conf
	sed -i -e "s:^\(Example\):\# \1:" \
		-e "s:.*\(PidFile\) .*:\1 /var/run/clamav/freshclam.pid:" \
		-e "s:.*\(DatabaseOwner\) .*:\1 clamav:" \
		-e "s:^\#\(UpdateLogFile\) .*:\1 /var/log/clamav/freshclam.log:" \
		${D}/etc/freshclam.conf

	if use milter ; then
		echo "START_MILTER=no" \
			>> ${D}/etc/conf.d/clamd
		echo "MILTER_SOCKET=\"/var/run/clamav/clmilter.sock\"" \
			>>${D}/etc/conf.d/clamd
		echo "MILTER_OPTS=\"-m 10 --timeout=0\"" \
			>>${D}/etc/conf.d/clamd
	fi
}

pkg_postinst() {
	echo
	ewarn "Warning: clamd and/or freshclam have not been restarted."
	ewarn "You should restart them with: /etc/init.d/clamd restart"
	echo
	if use milter ; then
		elog "For simple instructions how to setup the clamav-milter"
		elog "read /usr/share/doc/${PF}/clamav-milter.README.gentoo.gz"
		echo
	fi
	ewarn "This is a RELEASE CANDIDATE version, with EXPERIMENTAL code ENABLED."
	ewarn "USE AT YOUR OWN RISK"
	echo
	ebeep 3
}
