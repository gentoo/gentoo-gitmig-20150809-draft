# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.2-r5.ebuild,v 1.4 2002/07/14 19:20:19 aliz Exp $

inherit libtool
KEYWORDS="x86"
HOMEPAGE="http://shadow.pld.org.pl/"
S=${WORKDIR}/${P}
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${P}.tar.gz"
LICENSE="BSD"

DEPEND=">=sys-libs/pam-0.75-r4
	>=sys-libs/cracklib-2.7-r3
	sys-devel/gettext"
	
RDEPEND=">=sys-libs/pam-0.75-r4
	>=sys-libs/cracklib-2.7-r3"

SLOT="0"

pkg_preinst() { 
	rm -f ${ROOT}/etc/pam.d/system-auth.new
}

src_compile() {
	elibtoolize

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
	make || die "compile problem"
}

src_install() {
	dodir /etc/default /etc/skel

	make prefix=${D}/usr \
		exec_prefix=${D} \
		mandir=${D}/usr/share/man \
		install || die "install problem"

	#do not install this login, but rather the one from
	#util-linux, as this one have a serious root exploit
	#with pam_limits in use.
	rm ${D}/bin/login

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
# From sys-apps/pam-login now
#	insopts -m0644 ; doins ${FILESDIR}/login.defs
	insinto /etc/pam.d ; insopts -m0644
	cd ${FILESDIR}/pam.d
	doins *
	newins system-auth system-auth.new
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
	
	#dont install the manpage, since we dont use
	#login with shadow
	rm ${D}/usr/share/man/man1/login.*
	
	cd ${S}/doc
	dodoc ANNOUNCE INSTALL LICENSE README WISHLIST
	docinto txt
	dodoc HOWTO LSM README.* *.txt
}

pkg_postinst() {
	echo
	echo "****************************************************"
	echo "   Due to a security issue, ${ROOT}etc/pam.d/system-auth "
	echo "   is being updated automatically. Your old "
	echo "   system-auth will be backed up as:"
	echo "   ${ROOT}etc/pam.d/system-auth.bak"
	echo "****************************************************"
	echo
	local CHECK1=`md5sum ${ROOT}/etc/pam.d/system-auth | cut -d ' ' -f 1`
	local CHECK2=`md5sum ${ROOT}/etc/pam.d/system-auth.new | cut -d ' ' -f 1`

	if [ "$CHECK1" != "$CHECK2" ];
	then
		cp -a ${ROOT}/etc/pam.d/system-auth \
	              ${ROOT}/etc/pam.d/system-auth.bak;
		mv -f ${ROOT}/etc/pam.d/system-auth.new \
	              ${ROOT}/etc/pam.d/system-auth
	else
		rm -f ${ROOT}/etc/pam.d/system-auth.new
	fi
}

