# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_ftpd/mod_ftpd-0.12.3.ebuild,v 1.5 2005/01/30 20:16:47 hollow Exp $

inherit eutils

DESCRIPTION="Apache2 protocol module which provides an FTP server"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_ftpd/"
SRC_URI="http://www.outoforder.cc/downloads/${PN}/${P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE="gdbm"

DEPEND="=net-www/apache-2*
	gdbm? ( >=sys-libs/gdbm-1.8.0-r5 )"

src_compile() {

	epatch ${FILESDIR}/0.12.3-mod_ftpd-ipv6.patch || die
	local providers="default fail"

	use gdbm && providers="dbm ${providers}"
	use dbi && providers="dbi ${providers}"

	econf \
		--with-apxs=/usr/sbin/apxs2 \
		--enable-providers="${providers}" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/mod_ftpd.so providers/*/.libs/*.so

	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/mod_ftpd.conf

	dohtml docs/manual.html
	dodoc docs/manual.pdf AUTHORS ChangeLog README TODO
}
