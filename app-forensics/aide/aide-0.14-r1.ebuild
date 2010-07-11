# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/aide/aide-0.14-r1.ebuild,v 1.3 2010/07/11 11:13:03 armin76 Exp $

EAPI="3"

inherit autotools confutils eutils

DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a replacement for Tripwire"
HOMEPAGE="http://aide.sourceforge.net/"
SRC_URI="mirror://sourceforge/aide/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="acl audit curl mhash nls postgres selinux static xattr zlib"
#IUSE="acl audit curl mhash nls postgres prelink selinux static xattr zlib"

# libsandbox:  Can't dlopen libc: (null)
#RESTRICT="test"

DEPEND="acl? ( virtual/acl )
	audit? ( sys-process/audit )
	curl? ( net-misc/curl )
	mhash? ( >=app-crypt/mhash-0.9.2 )
	!mhash? ( dev-libs/libgcrypt )
	nls? ( virtual/libintl )
	postgres? ( dev-db/postgresql-base )
	selinux? ( sys-libs/libselinux )
	xattr? ( sys-apps/attr )
	zlib? ( sys-libs/zlib )"
#	prelink? ( sys-devel/prelink )

RDEPEND="!static? ( ${DEPEND} )"

DEPEND="${DEPEND}
	nls? ( sys-devel/gettext )
	sys-devel/bison
	sys-devel/flex"

pkg_config() {
	confutils_use_conflict mhash postgres
	confutils_use_conflict curl static
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"

	# fix libgcrypt issue, bug #266175
	epatch "${FILESDIR}/${PN}-0.13.1-libgrypt_init.patch"

	# fix as-need issue, bug #271326
	epatch "${FILESDIR}/${P}-as-needed.patch"

	# fix zlib issue, bug #316665
	epatch "${FILESDIR}/${PN}-0.13.1-zlib.patch"

	# fix configure issue, bug #323187
	epatch "${FILESDIR}/${P}-configure.patch"

	if ! use selinux ; then
		sed -i -e 's/\+selinux//' doc/aide.conf.in || die
	fi

	if ! use xattr ; then
		sed -i -e 's/\+xattrs//' doc/aide.conf.in || die
	fi

	if ! use acl ; then
		sed -i -e 's/\+acl//' doc/aide.conf.in || die
	fi

	eautoreconf
}

src_configure() {
	econf \
		$(use_with acl posix-acl) \
		$(use_with audit) \
		$(use_with curl) \
		$(use_with !mhash gcrypt) \
		$(use_with mhash mhash) \
		$(use_with nls locale) \
		$(use_with postgres psql) \
		$(use_with selinux) \
		$(use_enable static) \
		$(use_with xattr) \
		$(use_with zlib) \
		--sysconfdir="${EPREFIX}/etc/aide" || die "econf failed"
#		$(use_with prelink)
}

src_install() {
	emake DESTDIR="${D}" install install-man || die "emake install failed"

	keepdir /var/lib/aide || die
	fowners root:0 /var/lib/aide || die
	fperms 0755 /var/lib/aide || die

	keepdir /var/log/aide || die

	insinto /etc/aide
	doins "${FILESDIR}"/aide.conf || die

	dosbin "${FILESDIR}"/aideinit || die

	dodoc ChangeLog AUTHORS NEWS README "${FILESDIR}"/aide.cron || die
	dohtml doc/manual.html || die
}

pkg_postinst() {
	elog
	elog "A sample configuration file has been installed as"
	elog "/etc/aide/aide.conf.  Please edit to meet your needs."
	elog "Read the aide.conf(5) manual page for more information."
	elog "A helper script, aideinit, has been installed and can"
	elog "be used to make AIDE management easier. Please run"
	elog "aideinit --help for more information"
	elog

	if use postgres; then
		elog "Due to a bad assumption by aide, you must issue the following"
		elog "command after the database initialization (aide --init ...):"
		elog
		elog 'psql -c "update pg_index set indisunique=false from pg_class \\ '
		elog "  where pg_class.relname='TABLE_pkey' and \ "
		elog '  pg_class.oid=pg_index.indexrelid" -h HOSTNAME -p PORT DBASE USER'
		elog
		elog "where TABLE, HOSTNAME, PORT, DBASE, and USER are the same as"
		elog "your aide.conf."
		elog
	fi
}
