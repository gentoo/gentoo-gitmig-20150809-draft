# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-addons/asterisk-addons-1.2.0_beta1.ebuild,v 1.1 2005/08/27 18:19:39 stkn Exp $

IUSE="mysql sqlite h323"

inherit eutils flag-o-matic

## TODO:
#
# - cleanup
#

#AST_PATCHES_PV="1.2.0_pre-1.0"
SQLITE_PV="3.2.1"

MY_P="${P/_/-}"

DESCRIPTION="Additional Plugins for Asterisk"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://ftp.digium.com/pub/asterisk/${MY_P}.tar.gz
	 sqlite? ( http://www.sqlite.org/sqlite-${SQLITE_PV}.tar.gz )"

S=${WORKDIR}/${MY_P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="
	>=net-misc/asterisk-1.2.0_beta1
	mysql? ( dev-db/mysql )"

pkg_setup() {
	local n dosleep=0
	einfo "Running pre-flight checks..."

	if use h323 && built_with_use net-misc/asterisk h323; then
		echo
		ewarn "h323: Emerging ${PN} with the h323 flag enabled will overwrite asterisk's chan_h323.so!"
		ewarn "h323: Be sure to upgrade ${ROOT}etc/asterisk/h323.conf afterwards!"
		dosleep=1
	fi

	echo
	if [[ $dosleep -gt 0 ]]; then
		ebeep
	        n=10
	        while [[ $n -gt 0 ]]; do
			echo -en "  Waiting $n seconds...\r"
			sleep 1
			(( n-- ))
	        done
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	#
	# gentoo patchset
	#
	epatch ${FILESDIR}/${P}-gentoo-base.diff
	epatch ${FILESDIR}/${P}-gentoo-res_sqlite3.diff
	epatch ${FILESDIR}/${P}-gentoo-ooh323c.diff

	# patch sqlite
	if use sqlite; then
		cd ${WORKDIR}/sqlite-${SQLITE_PV}

		epatch ${FILESDIR}/sqlite-${SQLITE_PV}-data-corruption.patch
		epunt_cxx
	fi

	# rebuild ooh323c configure
	if use h323; then
		cd ${S}/asterisk-ooh323c
		libtoolize --copy --force || die "libtoolize failed"
	fi
}

src_compile() {
	append-flags -fPIC

	emake -j1 || die "Make failed"

	if use sqlite; then
		cd ${WORKDIR}/sqlite-${SQLITE_PV}
		econf --enable-threadsafe || die ""
		emake || die ""

		cd ${S}
		emake -j1 -C res_sqlite3 \
			SQLITEDIR=${WORKDIR}/sqlite-${SQLITE_PV} || die "Make res_sqlite failed"
	fi

	if use h323; then
		cd ${S}/asterisk-ooh323c
		econf || die "econf failed"
		emake || die "emake failed"
	fi
}

src_install() {
	make DESTDIR=${D} install || die "Make install failed"

	if use sqlite; then
		make -C res_sqlite3 \
			DESTDIR=${D} install || die "Make install res_sqlite3 failed"
	fi

	if use h323; then
		make -C asterisk-ooh323c \
			DESTDIR=${D} install || die "Make instal ooh323c failed"
	fi

	# install standard docs...
	dodoc README
	dodoc doc/cdr_mysql.txt

	insinto /usr/share/doc/${PF}
	doins configs/*.sample

	if use sqlite; then
		cd ${S}/res_sqlite3
		docinto res_sqlite3
		dodoc README
		insinto /usr/share/doc/${PF}/res_sqlite3
		doins res_sqlite.conf dialplan.sql
		keepdir /var/lib/asterisk/sqlite
	fi

	if use h323; then
		cd ${S}/asterisk-ooh323c
		docinto chan_ooh323c
		dodoc AUTHORS INSTALL NEWS README COPYING ChangeLog
		dodoc h323.conf.sample extensions.conf.sample

		insinto /etc/asterisk
		newins h323.conf.sample h323.conf
	fi

	einfo "Fixing permissions"
	chown -R root:asterisk ${D}etc/asterisk
	chmod -R u=rwX,g=rX,o= ${D}etc/asterisk

	chown -R asterisk:asterisk ${D}var/lib/asterisk
	chmod -R u=rwX,g=rX,o=     ${D}var/lib/asterisk
}

#pkg_postinst() {
#	#
#	# Announcements, warnings, reminders...
#	#
#}
