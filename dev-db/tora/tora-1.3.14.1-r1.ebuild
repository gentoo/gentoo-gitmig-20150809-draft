# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tora/tora-1.3.14.1-r1.ebuild,v 1.1 2004/10/29 16:13:09 rizzo Exp $

inherit debug eutils

IUSE="kde oracle debug"
DESCRIPTION="TOra - Toolkit For Oracle"
HOMEPAGE="http://www.globecom.se/tora/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-alpha-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND=">=x11-libs/qt-3.0.0
	dev-lang/perl
	kde? ( >=kde-base/kdelibs-3.1 )"

pkg_setup() {
	if use oracle && [ -z "$ORACLE_HOME" ] ; then
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

src_unpack() {
	unpack ${A}
	cd ${S}
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1025950&group_id=16636&atid=316636
	epatch ${FILESDIR}/tora-1.3.14.1-triggers.diff

	# http://sourceforge.net/tracker/index.php?func=detail&aid=996061&group_id=16636&atid=316636

	epatch ${FILESDIR}/tora-1.3.14.1-invalidobjects.diff
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1048530&group_id=16636&atid=316636
	epatch ${FILESDIR}/tora-1.3.14.1-race.patch
}

src_compile() {

	# Need to fake out Qt or we'll get sandbox problems
	REALHOME="$HOME"
	mkdir -p $T/fakehome/.kde
	mkdir -p $T/fakehome/.qt
	export HOME="$T/fakehome"
	addwrite "${QTDIR}/etc/settings"

	local myconf
	myconf="--prefix=/usr"
	myconf="$myconf --with-mono"

	use kde \
		&& myconf="$myconf --with-kde" \
		|| myconf="$myconf --without-kde"
	use oracle || myconf="$myconf --without-oracle"

	./configure $myconf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make install ROOT=${D}
	dodoc LICENSE.txt BUGS INSTALL NEWS README TODO
}
