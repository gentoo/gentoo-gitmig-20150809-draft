# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.1-r2.ebuild,v 1.4 2002/08/01 11:59:04 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${P}.tar.gz"
DEPEND=">=sys-libs/pam-0.73 sys-devel/gettext"
RDEPEND=">=sys-libs/pam-0.73"
HOMEPAGE="http://shadow.pld.org.pl/"
KEYWORDS="x86"
SLOT="0"
LICENSE="BSD"

src_compile() {
	./configure \
	--disable-desrpc \
	--with-libcrypt \
	--with-libcrack \
	--with-libpam \
	--enable-shared=yes \
	--enable-static=yes \
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
	dosym /usr/bin/newgrp /usr/bin/sg
	dosym /usr/sbin/useradd /usr/sbin/adduser
	dosym /usr/sbin/vipw /usr/sbin/vigr
	# remove dead links
	rm -f ${D}/bin/{sg,vipw}

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
	doins ${FILESDIR}/chage chage
	cd ${S}/doc
	dodoc ANNOUNCE INSTALL LICENSE README WISHLIST
	docinto txt
	dodoc HOWTO LSM README.* *.txt

	# install missing manpages
	doman ${S}/man/{shadow.3,shadowconfig.8}
}
