# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer System Team <system@gentoo.org>
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/LPRng/LPRng-3.7.9.ebuild,v 1.1 2001/10/31 18:10:16 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Extended implementation of the Berkley LPR print spooler"
SRC_URI="ftp://ftp.lprng.com/pub/LPRng/LPRng/${P}.tgz"
HOMEPAGE="http://www.lprng.com/"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	!net-print/cups"
RDEPEND="virtual/glibc"
PROVIDE="virtual/lpr"

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
	diropts -m 700 -o lp -g lp ; dodir /var/spool/lpd/lp

	make \
	DESTDIR=${D} \
	POSTINSTALL="NO" \
	gnulocaledir=${D}/usr/share/locale \
	install || die

	exeinto /usr/bin ; doexe ${FILESDIR}/lpdomatic

	dodoc CHANGES COPYRIGHT LICENSE README VERSION
	dodoc HOWTO/LPRng-HOWTO.pdf
	newdoc ${FILESDIR}/printcap printcap.sample
	newdoc lpd.conf lpd.conf.sample
	newdoc lpd.perms lpd.perms.sample
	docinto html ; dodoc HOWTO/{LPRng-HOWTO.html,*.jpg}

	insinto /etc/lprng
	newins ${FILESDIR}/printcap printcap.sample
	newins lpd.conf lpd.conf.sample
	newins lpd.perms lpd.perms.sample

	exeinto /etc/rc.d/init.d ; newexe ${FILESDIR}/lprng.rc5 lprng
}
