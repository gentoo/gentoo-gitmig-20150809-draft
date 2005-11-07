# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/aide/aide-0.11_rc2.ebuild,v 1.1 2005/11/07 12:58:58 dragonheart Exp $

inherit eutils

DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a replacement for Tripwire"
HOMEPAGE="http://aide.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
IUSE="nls postgres zlib crypt"

DEPEND="app-arch/gzip
	sys-devel/bison
	sys-devel/flex
	app-crypt/mhash
	crypt? ( dev-libs/libgcrypt )
	postgres? ( dev-db/postgresql )
	zlib? ( sys-libs/zlib )"
RDEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P/_/-}

src_unpaick() {
	unpack ${A}
	cd ${S}

	use postgres && epatch ${FILESDIR}/${PF}-fix-psql.diff
	epatch ${FILESDIR}/${MY_PF}-gentoo.diff

	export WANT_AUTOCONF='2.5'
	export WANT_AUTOMAKE='1.7'
	sh autogen.sh || die "autogen.sh failed"
}

src_compile() {
	# passing --without-psql or --with-psql causes postgres to be enabled ...
	# it's a broken configure.in file ... so lets just work around it
	local myconf=""
	use postgres && myconf="$myconf --with-psql"
	use crypt    && myconf="$myconf --with-gcrypt"

	econf \
		$(use_with zlib) \
		$(use_with nls locale) \
		--with-mhash \
		--sysconfdir=/etc/aide \
		--with-extra-lib=/usr/lib \
		${myconf} \
		|| die
	emake || die
}

src_test() {
	# aide abort()'s inside the sandbox for some reason
	#if ! has sandbox ${FEATURES};
	if 1;
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

	echo
	einfo "A sample configuration file has been installed as"
	einfo "/etc/aide/aide.conf.  Please edit to meet your needs."
	einfo "Read the aide.conf(5) manual page for more information."
	einfo "A cron file has been installed in /etc/cron.daily/aide.cron"
	einfo "A helper script, aideinit, has been installed and can"
	einfo "be used to make AIDE management easier. Please run"
	einfo "aideinit --help for more information"
	echo

	if use postgres; then
		einfo "Due to a bad assumption by aide, you must issue the following"
		einfo "command after the database initialization (aide --init ...):"
		einfo
		einfo 'psql -c "update pg_index set indisunique=false from pg_class \\ '
		einfo "  where pg_class.relname='TABLE_pkey' and \ "
		einfo '  pg_class.oid=pg_index.indexrelid" -h HOSTNAME -p PORT DBASE USER'
		einfo
		einfo "where TABLE, HOSTNAME, PORT, DBASE, and USER are the same as"
		einfo "your aide.conf."
		echo
	fi
}
