# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-3.1.7-r3.ebuild,v 1.2 2002/04/30 22:13:33 sandymac Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
LICENSE="GPL-2"
SRC_URI="ftp://ftp.kernel.org/pub/linux/daemons/autofs/${P}.tar.bz2
	ftp://ftp.de.kernel.org/pub/linux/daemons/autofs/${P}.tar.bz2
	ftp://ftp.uk.kernel.org/pub/linux/daemons/autofs/${P}.tar.bz2"
DEPEND="virtual/glibc ldap? ( ~net-nds/openldap-1.2 )"

src_unpack() {
	unpack ${A} ; cd ${S}/include
	patch -p0 < ${FILESDIR}/automount.diff || die
}

src_compile() {
	local myconf
	use ldap || myconf="--without-openldap"
	./configure --host=${HOST} --prefix=/usr ${myconf} || die
	emake || die
}

src_install() {
	into /usr
	dosbin daemon/automount
	insinto /usr/lib/autofs
	insopts -m 755
	doins modules/*.so

	dodoc COPYING COPYRIGHT NEWS README* TODO
	cd man
	doman auto.master.5 autofs.5 autofs.8 automount.8

	cd ../samples
	dodir /etc/autofs
	cp ${FILESDIR}/auto.master ${D}/etc/autofs
	cp ${FILESDIR}/auto.misc ${D}/etc/autofs

	exeinto /etc/init.d ; newexe ${FILESDIR}/autofs.rc6 autofs
	insinto /etc/conf.d ; newins ${FILESDIR}/autofs.confd autofs
}
