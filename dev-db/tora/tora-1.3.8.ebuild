# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tora/tora-1.3.8.ebuild,v 1.5 2003/09/06 22:25:50 msterret Exp $

DESCRIPTION="TOra - Toolkit For Oracle"
HOMEPAGE="http://www.globecom.se/tora/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${PN}-alpha-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/qt-3.0.0
	mysql? ( >=dev-db/mysql-3.23 )
	postgres? ( >=dev-db/postgresql-7.1 )"

pkg_setup() {
	if [ "`use oci8`" -a ! $ORACLE_HOME ] ; then
		einfo "ORACLE_HOME variable is not set."
		einfo ""
                einfo "You must install Oracle >= 8i client for Linux in"
		einfo "order to compile TOra with Oracle support."
		einfo ""
		einfo "Otherwise specify -oci8 in your USE variable."
		einfo ""
		einfo "You can download the Oracle software from"
		einfo "http://otn.oracle.com/software/content.html"
		die
	fi
}

src_compile() {
	local myconf

	use kde \
		&& myconf="$myconf --with-kde" \
		|| myconf="$myconf --without-kde"
	use mysql \
		&& myconf="$myconf" \
		|| myconf="$myconf --without-mysql"
#	use postgres	&& myconf="$myconf" \
#				|| myconf="$myconf --without-postgres"
	use oci8 \
		&& myconf="$myconf" \
		|| myconf="$myconf --without-oracle"

	#patch -p0 < ${FILESDIR}/tora-${PV}.patch

	./configure \
		--prefix=/usr \
		--with-mono \
		$myconf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	dodir ${D}/usr/bin
	make \
		ROOT=${D} \
		install || die "make install failed"
}
