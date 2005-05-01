# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/audit/audit-0.7.ebuild,v 1.1 2005/05/01 02:19:00 robbat2 Exp $

DESCRIPTION="Userspace utilities for storing and processing auditing records .."
HOMEPAGE="http://people.redhat.com/sgrubb/audit/"
SRC_URI="http://people.redhat.com/sgrubb/audit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-devel/libtool
	virtual/os-headers
	>=sys-devel/automake-1.9
	>=sys-devel/autoconf-2.59"
RDEPEND=""

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd '${S}' failed"
	WANT_AUTOMAKE="1.9" \
		autoreconf -fv --install || die "autoreconf failed"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "emake install failed"
	rm -rf ${D}/etc/rc.d ${D}/etc/sysconfig
	dodoc AUTHORS ChangeLog README THANKS TODO
	exeinto /etc/init.d
	newexe ${FILESDIR}/auditd.initd auditd
}
