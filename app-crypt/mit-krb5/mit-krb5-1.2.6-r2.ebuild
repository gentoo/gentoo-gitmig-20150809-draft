# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5/mit-krb5-1.2.6-r2.ebuild,v 1.4 2003/04/21 23:43:57 method Exp $

S=${WORKDIR}/krb5-${PV}/src
SRC_URI="http://www.crypto-publish.org/dist/mit-kerberos5/krb5-${PV}.tar.gz"
DESCRIPTION="MIT Kerberos V"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
IUSE="krb4"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
PROVIDE="virtual/krb5"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/kadmin/v4server/
	epatch ${FILESDIR}/${P}-gentoo.diff
        cd ${S}
        epatch ${FILESDIR}/${PN}-1.2.2-gentoo.diff
}

src_compile() {

	local myconf
	
	use krb4 && myconf="${myconf} --with-krb4 --enable-krb4" \
		|| myconf="${myconf} --without-krb4 --disable-krb4"

	econf \
                --with-ccopts="${CFLAGS}" \
		--mandir=/usr/share/man \
		--localstatedir=/etc \
		--enable-shared \
		--host=${CHOST} \
		--prefix=/usr \
		--enable-dns \
		${myconf} || die

	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	cd ..
	dodoc README

	# Begin client rename and install
	for i in {telnetd,ftpd}
	do
		mv ${D}/usr/share/man/man8/${i}.8.gz ${D}/usr/share/man/man8/k${i}.8.gz
		mv ${D}/usr/sbin/${i} ${D}/usr/sbin/k${i}
	done
	for i in {rcp,rsh,telnet,v4rcp,ftp,rlogin}
	do
		mv ${D}/usr/share/man/man1/${i}.1.gz ${D}/usr/share/man/man1/k${i}.1.gz
		mv ${D}/usr/bin/${i} ${D}/usr/bin/k${i}
	done
										
	insinto /etc
	newins ${FILESDIR}/krb5.conf krb5.conf
	insinto /etc/krb5kdc
	newins ${FILESDIR}/kdc.conf kdc.conf
	insinto /etc/conf.d
	newins ${FILESDIR}/krb5.confd krb5
	exeinto /etc/init.d
	newexe ${FILESDIR}/krb5.initd krb5
}

pkg_postinst() {
	einfo "Configuration files are now under /etc."
	einfo "The client apps are now installed with the k prefix"
	eindo "(ie. kftp, kftpd, ktelnet, ktelnetd, etc...)"
}
