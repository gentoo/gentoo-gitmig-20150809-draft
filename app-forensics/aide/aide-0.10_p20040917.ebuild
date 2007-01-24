# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/aide/aide-0.10_p20040917.ebuild,v 1.9 2007/01/24 03:12:05 genone Exp $

inherit eutils

DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a replacement for Tripwire"
HOMEPAGE="http://aide.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha amd64"
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

	insinto /etc/aide
	doins doc/aide.conf

	dodoc ChangeLog AUTHORS NEWS README
	dohtml doc/manual.html
}

pkg_postinst() {
	elog
	elog "A sample configuration file has been installed as"
	elog "/etc/aide/aide.conf.  Please edit to meet your needs."
	elog "Read the aide.conf(5) manual page for more information."
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
