# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Donny Davies <woodchip@gentoo.org>
# $Header $

S=${WORKDIR}/${P}
DESCRIPTION="Extended implementation of the Berkley LPR print spooler"
HOMEPAGE="http://www.lprng.com/"
SRC_URI="ftp://ftp.lprng.com/pub/LPRng/LPRng/${P}.tgz"

PROVIDE="virtual/lpr"
DEPEND="virtual/glibc nls? ( sys-devel/gettext ) !net-print/cups"
RDEPEND="virtual/glibc"

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

	dodoc CHANGES COPYRIGHT LICENSE README VERSION HOWTO/LPRng-HOWTO.pdf
	dodoc ${FILESDIR}/printcap lpd.conf lpd.perms
	docinto html ; dodoc HOWTO/{LPRng-HOWTO.html,*.jpg}

	insinto /etc/lprng
	doins ${FILESDIR}/printcap lpd.conf lpd.perms
	exeinto /etc/init.d ; newexe ${FILESDIR}/lprng.rc6 lprng
}
