# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pam-login/pam-login-3.6-r2.ebuild,v 1.16 2004/02/17 08:25:15 mr_bones_ Exp $

MY_PN="${PN/pam-/pam_}"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Based on the sources from util-linux, with added pam and shadow features"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/pam/${MY_PN}/${MY_PN}-${PV}.tar.bz2"
HOMEPAGE="http://www.thkukuk.de/pam/pam_login/"
KEYWORDS="x86 amd64 ppc sparc alpha"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	sys-libs/pam
	>=sys-apps/shadow-4.0.2-r5"

SLOT="0"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p1 <${FILESDIR}/${P}-SUPATH.patch || die
}

src_compile() {
	local myconf=""
	use nls || {
		myconf="--disable-nls"
		touch ${S}/intl/libintl.h
	}

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		rootexecbindir=${D}/bin \
		mandir=${D}/usr/share/man \
		sysconfdir=${D}/etc \
		install || die

	insinto /etc
	insopts -m0644
	newins ${FILESDIR}/login.defs login.defs.new

	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS
}

pkg_preinst() {
	rm -f ${ROOT}/etc/login.defs.new
}

pkg_postinst() {
	ewarn "Due to a compatibility issue, ${ROOT}etc/login.defs "
	ewarn "is being updated automatically. Your old login.defs"
	ewarn "will be backed up as:  ${ROOT}etc/login.defs.bak"
	echo

	local CHECK1=`md5sum ${ROOT}/etc/login.defs | cut -d ' ' -f 1`
	local CHECK2=`md5sum ${ROOT}/etc/login.defs.new | cut -d ' ' -f 1`

	if [ "$CHECK1" != "$CHECK2" ];
	then
		cp -a ${ROOT}/etc/login.defs ${ROOT}/etc/login.defs.bak;
		mv -f ${ROOT}/etc/login.defs.new ${ROOT}/etc/login.defs
	elif [ ! -f ${ROOT}/etc/login.defs ]
	then
		mv -f ${ROOT}/etc/login.defs.new ${ROOT}/etc/login.defs
	else
		rm -f ${ROOT}/etc/login.defs.new
	fi
}
