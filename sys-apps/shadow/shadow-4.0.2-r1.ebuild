# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.2-r1.ebuild,v 1.1 2002/03/25 21:04:52 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${P}.tar.gz"

DEPEND=">=sys-libs/pam-0.75-r4
	>=sys-libs/cracklib-2.7-r3
	sys-devel/gettext"
	
RDEPEND=">=sys-libs/pam-0.75-r4
	>=sys-libs/cracklib-2.7-r3"

src_compile() {
	local myconf=""
	use nls || myconf="${myconf} --disable-nls"
				
	./configure --disable-desrpc \
		--with-libcrypt \
		--with-libcrack \
		--with-libpam \
		--enable-shared=no \
		--enable-static=yes \
		--host=${CHOST} \
		${myconf} || die "bad configure"
		
	# Parallel make fails sometimes
	make LDFLAGS="" || die "compile problem"
}

src_install() {
	dodir /etc/default /etc/skel

	make prefix=${D}/usr \
		exec_prefix=${D} \
		mandir=${D}/usr/share/man \
		install || die "install problem"

	mv ${D}/lib ${D}/usr
	dosed "s:/lib':/usr/lib':g" /usr/lib/libshadow.la
	dosed "s:/lib/:/usr/lib/:g" /usr/lib/libshadow.la
	dosed "s:/lib':/usr/lib':g" /usr/lib/libmisc.la
	dosed "s:/lib/:/usr/lib/:g" /usr/lib/libmisc.la
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
	cd ${FILESDIR}/pam.d
	doins *
	newins shadow chage
	newins shadow chsh
	newins shadow chfn
	newins shadow useradd
	newins shadow groupadd
	cd ${S}

	# the manpage install is beyond my comprehension, and also broken.
	# just do it over.
	rm -rf ${D}/usr/share/man/*
	for q in man/*.[0-9]
	do
		local dir="${D}/usr/share/man/man${q##*.}"
		mkdir -p $dir
		cp $q $dir
	done
	
	cd ${S}/doc
	dodoc ANNOUNCE INSTALL LICENSE README WISHLIST
	docinto txt
	dodoc HOWTO LSM README.* *.txt
}

pkg_postinst() {
	echo
	echo "****************************************************"
	echo "  This version of shadow uses CRACKLIB to check"
	echo "  passwords, and for it to work properly, a reboot"
	echo "  is needed, sorry."
	echo "****************************************************"
	echo
}

