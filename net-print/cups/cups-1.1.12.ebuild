# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Donny Davies <woodchip@gentoo.org>
# Maintainer: System Team <system@gentoo.org>
# $Header $

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="http://www.cups.org"

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.easysw.com/pub/cups/${PV}/${P}-source.tar.bz2"
PROVIDE="virtual/lpr"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.75 )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	slp? ( >=net-libs/openslp-1.0.4 )
	>=media-libs/libpng-1.0.12
	>=media-libs/tiff-3.5.5
	>=media-libs/jpeg-6b
	!net-print/LPRng"

src_unpack() {

	unpack ${A} ; cd ${S}
	# make sure libcupsimage gets linked with libjpeg
	patch -p0 < ${FILESDIR}/configure-jpeg-buildfix.diff
	assert "bad patchfile"
	autoconf || die
}

src_compile() {

	local myconf
	use pam || myconf="${myconf} --disable-pam"
	use ssl || myconf="${myconf} --disable-ssl"
        use slp || myconf="${myconf} --disable-slp"

	./configure --host=${CHOST} ${myconf} --with-cups-user=lp --with-cups-group=lp
	assert "bad configure"

	make || die "compile problem"
}

src_install() {

	# set these up now or make install will.. and that aint pretty!
	diropts -m 755 ; dodir /var/spool
	diropts -m 755 ; dodir /var/log/cups
	diropts -m 755 ; dodir /etc/cups

	# lets do it this way
	make \
	LOCALEDIR=${D}/usr/share/locale \
	DOCDIR=${D}/usr/share/doc/${PF} \
	REQUESTS=${D}/var/spool/cups \
	SERVERBIN=${D}/usr/lib/cups \
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
	LIBDIR=${D}/usr/lib \
	BINDIR=${D}/usr/bin \
	bindir=${D}/usr/bin \
	INITDIR=${D}/etc \
	PREFIX=${D} \
	install || die "install problem"

	# add a few more docs; pdfs and html get inserted for us in DOCDIR above :)
	dodoc {CHANGES,CREDITS,ENCRYPTION,LICENSE,README}.txt
	insinto /usr/share/doc/${PF} ; doins LICENSE.html

	# cleanups and fixups
	rm -rf ${D}/etc/init.d
	rm -rf ${D}/etc/pam.d
	rm -rf ${D}/etc/rc*
	rm -rf ${D}/usr/share/man/cat*
	dosed "s:#DocumentRoot /usr/share/doc/cups:DocumentRoot /usr/share/doc/${PF}:" /etc/cups/cupsd.conf
	dosed "s:#SystemGroup sys:SystemGroup lp:" /etc/cups/cupsd.conf
	dosed "s:#User lp:User lp:" /etc/cups/cupsd.conf
	dosed "s:#Group sys:Group lp:" /etc/cups/cupsd.conf

	# sanity checks
	chown lp.root ${D}/usr/bin/lppasswd ; chmod 4755 ${D}/usr/bin/lppasswd
	chown lp.root ${D}/etc/cups/certs ; chmod 711 ${D}/etc/cups/certs
	chown lp.root ${D}/var/spool/cups ; chmod 0700 ${D}/var/spool/cups
	chown lp.root ${D}/var/spool/cups/tmp ; chmod 01700 ${D}/var/spool/cups/tmp

	# gentoo config stuff
	insinto /etc/pam.d ; newins ${FILESDIR}/cups.pam cups
	exeinto /etc/init.d ; newexe ${FILESDIR}/cupsd.rc6 cupsd
	insinto /etc/xinetd.d ; newins ${FILESDIR}/cups.xinetd cups-lpd
}
