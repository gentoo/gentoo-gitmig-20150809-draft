# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/lprng/lprng-3.8.12.ebuild,v 1.9 2003/05/31 14:15:59 pvdabeel Exp $

IUSE="nls"

MY_PN=LPRng

S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Extended implementation of the Berkley LPR print spooler"
HOMEPAGE="http://www.lprng.com/"
KEYWORDS="x86 ppc sparc alpha"
SRC_URI="ftp://ftp.lprng.com/pub/${MY_PN}/${MY_PN}/${MY_PN}-${PV}.tgz"

PROVIDE="virtual/lpr"
DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc !virtual/lpr"
LICENSE="GPL-2 | Artistic"
SLOT="0"

src_compile() {
	local myconf
	use nls && myconf="--enable-nls"

	# wont compile with -O3, needs -O2
	export CFLAGS="${CFLAGS/-O[3456789]/-O2}"

	./configure \
		--prefix=/usr \
		--disable-setuid \
		--with-userid=lp \
		--with-groupid=lp \
		--libexecdir=/usr/lib \
		--sysconfdir=/etc/lprng \
		--mandir=/usr/share/man \
		--host=${CHOST} ${myconf} || die

	make || die "printer on fire!"
}

src_install() {
	dodir /var/spool/lpd
	diropts -m 700 -o lp -g lp
	dodir /var/spool/lpd/lp

	make install \
		DESTDIR=${D} \
		POSTINSTALL="NO" \
		gnulocaledir=${D}/usr/share/locale || die

	exeinto /usr/bin
	doexe ${FILESDIR}/lpdomatic

	dodoc CHANGES COPYRIGHT LICENSE README VERSION \
		HOWTO/LPRng-HOWTO.pdf ${FILESDIR}/printcap \
		lpd.conf lpd.perms
	dohtml HOWTO/*

	insinto /etc/lprng
	doins ${FILESDIR}/printcap lpd.conf lpd.perms
	exeinto /etc/init.d
	newexe ${FILESDIR}/lprng-init lprng
}
