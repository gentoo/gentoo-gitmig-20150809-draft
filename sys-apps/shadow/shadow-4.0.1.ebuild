# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.1.ebuild,v 1.1 2002/01/15 21:55:23 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${P}.tar.gz"
DEPEND=">=sys-libs/pam-0.73 sys-devel/gettext"
RDEPEND=">=sys-libs/pam-0.73"

src_compile() {
	./configure \
	--disable-desrpc \
	--with-libcrypt \
	--with-libcrack \
	--with-libpam \
	--host=${CHOST} || die "bad configure"
	# Parallel make fails sometimes
	make LDFLAGS="" || die "compile problem"
}

src_install() {
	dodir /etc/default /etc/skel

	make \
	prefix=${D}/usr \
	exec_prefix=${D} \
	mandir=${D}/usr/share/man \
	install || die "install problem"

	mv ${D}/lib ${D}/usr
	dosed -e "s:/lib:/usr/lib:" -e "s: libshadow.so':':" /usr/lib/libshadow.la
	dosym /usr/sbin/useradd /usr/sbin/adduser
	dosym /usr/sbin/vipw /usr/sbin/vigr

	insinto /etc
	# Using a securetty with devfs device names added
	# (compat names kept for non-devfs compatibility)
	insopts -m0600 ; doins ${FILESDIR}/securetty
	insopts -m0600 ; doins ${S}/etc/login.access
	insopts -m0644 ; doins ${S}/etc/limits
	insopts -m0644 ; doins ${FILESDIR}/login.defs
	insinto /etc/pam.d ; insopts -m0644
	doins ${FILESDIR}/shadow
	newins ${FILESDIR}/shadow groupadd
	newins ${FILESDIR}/shadow useradd
	newins ${FILESDIR}/shadow chage
	cd ${S}/doc
	dodoc ANNOUNCE INSTALL LICENSE README WISHLIST
	docinto txt
	dodoc HOWTO LSM README.* *.txt
}
