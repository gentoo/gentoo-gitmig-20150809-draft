# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups/cups-1.1.20-r5.ebuild,v 1.1 2004/11/01 14:37:18 lanius Exp $

inherit eutils flag-o-matic

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="http://www.cups.org/"
SRC_URI="ftp://ftp.easysw.com/pub/cups/${PV}/${P}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
IUSE="ssl slp pam"

DEP="virtual/libc
	pam? ( >=sys-libs/pam-0.75 )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	slp? ( >=net-libs/openslp-1.0.4 )
	>=media-libs/libpng-1.2.1
	>=media-libs/tiff-3.5.5
	>=media-libs/jpeg-6b"
DEPEND="${DEP}
	>=sys-devel/autoconf-2.58"
RDEPEND="${DEP}
	!virtual/lpr"
PROVIDE="virtual/lpr"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/disable-strip.patch
	epatch ${FILESDIR}/${P}-str633.patch
	epatch ${FILESDIR}/${P}-zero-len-udp-dos.patch
	epatch ${FILESDIR}/str920.patch
	( cd pdftops; epatch ${FILESDIR}/${P}-xpdf-CESA-2004-007.patch.bz2 )
	( cd pdftops; epatch ${FILESDIR}/xpdf-goo-sizet.patch )
	( cd pdftops; epatch ${FILESDIR}/${P}-xpdf2-underflow.patch )
	WANT_AUTOCONF=2.5 autoconf || die
}

src_compile() {
	filter-flags -fomit-frame-pointer

	local myconf
	use amd64 && replace-flags -Os -O2
	use pam || myconf="${myconf} --disable-pam"
	use ssl || myconf="${myconf} --disable-ssl"
	use slp || myconf="${myconf} --disable-slp"

	./configure \
		--with-cups-user=lp \
		--with-cups-group=lp \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	make || die "compile problem"
}

src_install() {
	dodir /var/spool /var/log/cups /etc/cups

	make \
	LOCALEDIR=${D}/usr/share/locale \
	DOCDIR=${D}/usr/share/cups/docs \
	REQUESTS=${D}/var/spool/cups \
	SERVERBIN=${D}/usr/$(get_libdir)/cups \
	DATADIR=${D}/usr/share/cups \
	INCLUDEDIR=${D}/usr/include \
	AMANDIR=${D}/usr/share/man \
	PMANDIR=${D}/usr/share/man \
	MANDIR=${D}/usr/share/man \
	SERVERROOT=${D}/etc/cups \
	LOGDIR=${D}/var/log/cups \
	SBINDIR=${D}/usr/sbin \
	PAMDIR=${D}/etc/pam.d \
	EXEC_PREFIX=${D}/usr \
	LIBDIR=${D}/usr/$(get_libdir) \
	BINDIR=${D}/usr/bin \
	bindir=${D}/usr/bin \
	INITDIR=${D}/etc \
	PREFIX=${D} \
	install || die "install problem"

	dodoc {CHANGES,CREDITS,ENCRYPTION,LICENSE,README}.txt
	dosym /usr/share/cups/docs /usr/share/doc/${PF}/html

	#seems nobody installs it like this anymore.. security risk?
	#fowners lp.root /usr/bin/lppasswd
	#fperms 4755 /usr/bin/lppasswd

	# cleanups
	rm -rf ${D}/etc/init.d
	rm -rf ${D}/etc/pam.d
	rm -rf ${D}/etc/rc*
	rm -rf ${D}/usr/share/man/cat*
	rm -rf ${D}/etc/cups/{certs,interfaces,ppd}
	rm -rf ${D}/var

	sed -i -e "s:^#\(DocumentRoot\).*:\1 /usr/share/cups/docs:" \
		-e "s:^#\(SystemGroup\).*:\1 lp:" \
		-e "s:^#\(User\).*:\1 lp:" \
		-e "s:^#\(Group\).*:\1 lp:" \
		${D}/etc/cups/cupsd.conf

	insinto /etc/pam.d ; newins ${FILESDIR}/cups.pam cups
	exeinto /etc/init.d ; newexe ${FILESDIR}/cupsd.rc6 cupsd
	insinto /etc/xinetd.d ; newins ${FILESDIR}/cups.xinetd cups-lpd

	#insinto /etc/cups; newins ${FILESDIR}/cupsd.conf-1.1.18 cupsd.conf
}

pkg_postinst() {
	install -d -m0755 ${ROOT}/var/log/cups
	install -d -m0755 ${ROOT}/var/spool
	install -m0700 -o lp -d ${ROOT}/var/spool/cups
	install -m1700 -o lp -d ${ROOT}/var/spool/cups/tmp
	install -m0711 -o lp -d ${ROOT}/etc/cups/certs
	install -d -m0755 ${ROOT}/etc/cups/{interfaces,ppd}

	einfo "If you're using a USB printer, \"emerge hotplug; rc-update add"
	einfo "hotplug default\" is something you should probably do. This"
	einfo "will allow any USB kernel modules (if present) to be loaded"
	einfo "automatically at boot."
}
