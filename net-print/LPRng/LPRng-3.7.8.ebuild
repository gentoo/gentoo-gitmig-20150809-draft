# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer System Team <system@gentoo.org>
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/LPRng/LPRng-3.7.8.ebuild,v 1.2 2001/10/07 07:58:43 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Extended implementation of the Berkley LPR print spooler"
SRC_URI="ftp://ftp.lprng.com/pub/LPRng/LPRng/${P}.tgz"
HOMEPAGE="http://www.lprng.com/"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"
PROVIDE="virtual/lpr"

src_compile() {
	local myconf
	use nls && myconf="--enable-nls"

	# wont compile with -O3, needs -O2
	export CFLAGS="${CFLAGS/-O[3456789]/-O2}"

	./configure --prefix=/usr --host=${CHOST} --sysconfdir=/etc/lprng \
	--mandir=/usr/share/man --libexecdir=/usr/lib --disable-setuid \
	--with-userid=lp --with-groupid=lp ${myconf} || die

	make || die "printer on fire!"
}

src_install() {
	make DESTDIR=${D} gnulocaledir=${D}/usr/share/locale \
	POSTINSTALL="NO" install || die

	exeinto /usr/bin ; doexe ${FILESDIR}/lpdomatic

	dodoc CHANGES COPYRIGHT LICENSE README VERSION
	newdoc ${FILESDIR}/printcap printcap.sample
	newdoc lpd.conf lpd.conf.sample
	newdoc lpd.perms lpd.perms.sample
	insinto /usr/share/doc/${P} ; doins HOWTO/LPRng-HOWTO.pdf
	insinto /usr/share/doc/${P}/html ; doins HOWTO/{LPRng-HOWTO.html,*.jpg}

	diropts -m 755 ; dodir /var/spool/lpd
	diropts -o lp -g lp -m 0700 ; dodir /var/spool/lpd/lp

	insinto /etc/lprng
	newins ${FILESDIR}/printcap printcap.sample
	newins lpd.conf lpd.conf.sample
	newins lpd.perms lpd.perms.sample

	exeinto /etc/rc.d/init.d
	newexe ${FILESDIR}/lprng.rc5 lprng
}
