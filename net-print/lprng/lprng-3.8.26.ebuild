# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/lprng/lprng-3.8.26.ebuild,v 1.2 2004/03/17 09:45:28 seemant Exp $

inherit eutils flag-o-matic

IUSE="nls"

MY_PN=LPRng

S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Extended implementation of the Berkeley LPR print spooler"
HOMEPAGE="http://www.lprng.com/"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
SRC_URI="ftp://ftp.lprng.com/pub/${MY_PN}/${MY_PN}/${MY_PN}-${PV}.tgz"

PROVIDE="virtual/lpr"

DEPEND="virtual/glibc
	sys-apps/procps
	nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc
	sys-apps/procps
	!virtual/lpr"

LICENSE="GPL-2 | Artistic"
SLOT="0"

src_compile() {
	local myconf
	use nls && myconf="--enable-nls"

	# wont compile with -O3, needs -O2
	replace-flags -O[3-9] -O2

	./configure \
		--prefix=/usr \
		--disable-setuid \
		--with-userid=lp \
		--with-groupid=lp \
		--with-lpd_conf_path=/etc/lprng/lpd.conf \
		--with-lpd_perms_path=/etc/lprng/lpd.perms \
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

	# now included in foomatic 3.0
	#exeinto /usr/bin
	#doexe ${FILESDIR}/lpdomatic

	dodoc CHANGES COPYRIGHT LICENSE README VERSION \
		HOWTO/LPRng-HOWTO.pdf ${FILESDIR}/printcap \
		lpd.conf lpd.perms
	dohtml HOWTO/*

	insinto /etc/lprng
	doins ${FILESDIR}/printcap lpd.conf lpd.perms
	exeinto /etc/init.d
	newexe ${FILESDIR}/lprng-init lprng
}

pkg_postinst() {
	einfo "If printing does not work, try 'checkpc'/'checkpc -f'"
}
