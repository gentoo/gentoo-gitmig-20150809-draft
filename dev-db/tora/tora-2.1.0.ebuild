# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tora/tora-2.1.0.ebuild,v 1.6 2010/01/11 18:43:17 abcd Exp $

EAPI=2

inherit eutils multilib

DESCRIPTION="TOra - Toolkit For Oracle"
HOMEPAGE="http://tora.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ~ppc ~sparc x86"
IUSE="debug mysql oracle oci8-instant-client postgres"

RDEPEND="${DEPEND}"
DEPEND="dev-lang/perl
	x11-libs/qt-sql[mysql?,postgres?]
	x11-libs/qscintilla
	oci8-instant-client? (
		dev-db/oracle-instantclient-basic
		dev-db/oracle-instantclient-sqlplus
	)"

pkg_setup() {
	if ( use oracle || use oci8-instant-client ) && [ -z "$ORACLE_HOME" ] ; then
		eerror "ORACLE_HOME variable is not set."
		eerror
		eerror "You must install Oracle >= 8i client for Linux in"
		eerror "order to compile TOra with Oracle support."
		eerror
		eerror "Otherwise specify -oracle in your USE variable."
		eerror
		eerror "You can download the Oracle software from"
		eerror "http://otn.oracle.com/software/content.html"
		die
	fi
}

src_configure() {
	local myconf

	if use oracle; then
		myconf="$myconf --with-oracle=${ORACLE_HOME}"
	fi

	if use oci8-instant-client; then
		myconf="$myconf --with-instant-client=${ORACLE_HOME}"
	fi

	if use oci8-instant-client || use oracle ; then
		myconf="$myconf --with-oracle-libraries=${ORACLE_HOME}/lib \
			--with-oracle-includes=${ORACLE_HOME}/include "
	fi

	econf \
		--with-qt-includes=/usr/include/qt4 \
		--with-qt-libraries=/usr/$(get_libdir)/qt4 \
		--with-qt-dir=/usr/$(get_libdir)/qt4 \
		$myconf
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die "install failed"
	dodoc BUGS INSTALL NEWS README TODO

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop || die
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/${PN}.png || die
}
