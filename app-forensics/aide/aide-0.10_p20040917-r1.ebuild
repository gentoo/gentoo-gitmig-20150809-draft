# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/aide/aide-0.10_p20040917-r1.ebuild,v 1.6 2007/09/04 14:04:42 angelos Exp $
WANT_AUTOCONF='2.5'
WANT_AUTOMAKE='1.7'
inherit eutils autotools

DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a replacement for Tripwire"
HOMEPAGE="http://aide.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ppc ~sparc ~x86"
IUSE="nls postgres zlib crypt"

DEPEND="app-arch/gzip
	sys-devel/bison
	sys-devel/flex
	app-crypt/mhash
	crypt? ( dev-libs/libgcrypt )
	postgres? ( dev-db/postgresql )
	zlib? ( sys-libs/zlib )"
RDEPEND="nls? ( sys-devel/gettext )"

MY_PF=${PF%%_*}
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	use postgres && epatch ${FILESDIR}/${PF}-fix-psql.diff
	epatch ${FILESDIR}/${MY_PF}-gentoo.diff

	eautoreconf
}

src_compile() {
	# passing --without-psql or --with-psql causes postgres to be enabled ...
	# it's a broken configure.in file ... so lets just work around it
	local myconf=""
	use postgres && myconf="$myconf --with-psql"
	use crypt    && myconf="$myconf --with-gcrypt"

	econf \
		`use_with zlib` \
		`use_with nls locale` \
		--with-mhash \
		--sysconfdir=/etc/aide \
		--with-extra-lib=/usr/lib \
		${myconf} \
		|| die
	emake || die
}

src_test() {
	# aide abort()'s inside the sandbox for some reason
	if ! has sandbox ${FEATURES};
	then
		src/aide --init -c doc/aide.conf -V20 \
			|| die "failed to initialise database"
		mv aide.db.new doc/aide.db
		make check || die "failed self test"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
	use nls || rm -rf ${D}/usr/lib/locale

	keepdir /var/lib/aide
	keepdir /var/log/aide

	insinto /etc/aide
	doins ${FILESDIR}/aide.conf

	exeinto /usr/sbin
	newexe ${FILESDIR}/aideinit aideinit

	exeinto /etc/cron.daily
	newexe ${FILESDIR}/aide.cron aide.cron

	dodoc ChangeLog AUTHORS NEWS README
	dohtml doc/manual.html
}

pkg_postinst() {
	chown root:0 /var/lib/aide
	chmod 0755 /var/lib/aide

	elog
	elog "A sample configuration file has been installed as"
	elog "/etc/aide/aide.conf.  Please edit to meet your needs."
	elog "Read the aide.conf(5) manual page for more information."
	elog "A cron file has been installed in /etc/cron.daily/aide.cron"
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
