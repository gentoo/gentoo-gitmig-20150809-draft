# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5/mit-krb5-1.2.8.ebuild,v 1.1 2003/06/06 23:53:04 rphillips Exp $

inherit eutils

MY_P=${PN/mit-}-${PV}
S=${WORKDIR}/${MY_P}/src
SRC_URI="http://www.mirrors.wiretapped.net/security/cryptography/apps/kerberos/krb5-mit/unix/${MY_P}.tar.gz"
DESCRIPTION="MIT Kerberos V"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
IUSE="krb4 static"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"
PROVIDE="virtual/krb5"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}

        # Fix bad errno definitions (bug #16450 and #16267)
        ebegin Fixing errno definitions
        find . -name '*.[ch]' | xargs grep -l 'extern.*int.*errno' \
          | xargs -n1 perl -pi.orig -e '
                $.==1 && s/^/#include <errno.h>\n/;
                s/extern\s+int\s+errno\s*\;//;'
        eend $?
}

src_compile() {
	local myconf
	
	use krb4 && myconf="${myconf} --with-krb4 --enable-krb4" \
		|| myconf="${myconf} --without-krb4 --disable-krb4"

 	use static && myconf="${myconf} --disable-shared --enable-static" \
 		|| myconf="${myconf} --enable-shared --disable-static"

	econf \
                --with-ccopts="${CFLAGS}" \
		--mandir=/usr/share/man \
		--localstatedir=/etc \
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
	dohtml doc/*.html

	# Begin client rename and install
	for i in {telnetd,ftpd}
	do
		mv ${D}/usr/share/man/man8/${i}.8 ${D}/usr/share/man/man8/k${i}.8
		mv ${D}/usr/sbin/${i} ${D}/usr/sbin/k${i}
	done
	for i in {rcp,rsh,telnet,v4rcp,ftp,rlogin}
	do
		mv ${D}/usr/share/man/man1/${i}.1 ${D}/usr/share/man/man1/k${i}.1
		mv ${D}/usr/bin/${i} ${D}/usr/bin/k${i}
	done
										
	insinto /etc
		newins ${FILESDIR}/krb5.conf krb5.conf
	insinto /etc/krb5kdc
		newins ${FILESDIR}/kdc.conf kdc.conf
	exeinto /etc/init.d
		newexe ${FILESDIR}/mit-krb5kadmind.initd mit-krb5kadmind
		newexe ${FILESDIR}/mit-krb5kdc.initd mit-krb5kdc
}

pkg_postinst() {
	einfo "See /usr/share/doc/${P}/html/admin.html for documentation."
	echo ""
	einfo "The client apps are installed with the k prefix"
	einfo "(ie. kftp, kftpd, ktelnet, ktelnetd, etc...)"
	echo ""
}
