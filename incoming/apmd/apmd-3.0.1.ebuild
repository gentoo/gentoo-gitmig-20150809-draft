# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>

S=${WORKDIR}/${P}
DESCRIPTION="Advanced Power Management Daemon"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/a/apmd/apmd_3.0.1-1.tar.gz"
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/apmd/"

src_compile() {

    try emake

}

src_install () {

	dodir /usr/
	dobin apm
	dobin on_ac_power
	dobin xapm
	dobin tailf
	dobin apmsleep
	dosbin apmd
	doman *.{1,8}
	dolib.a libapm.a

	insinto /usr/include
	insopts -m 0644
	doins apm.h

	insinto /etc/apm
	insopts -m 0755
	doins ${S}/debian/apmd_proxy

	insinto /etc/rc.d/init.d
	insopts -m 0755 
	doins ${FILESDIR}/apmd
	doins ${FILESDIR}/svc-apmd

	insinto /var/lib/supervise/services/apmd
	insopts -m 0755
	doins ${FILESDIR}/run

	dodoc ANNOUNCE BUGS.apmsleep COPYING COPYING.LIB ChangeLog LSM \
		README README.transfer 
}
