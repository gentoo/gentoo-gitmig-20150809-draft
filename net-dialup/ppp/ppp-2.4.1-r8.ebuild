# ChangeLog for net-dialuppppChangeLog/net-dialuppppppp-2.4.1-r8.ebuild
# Copyright 2002 Gentoo Technologies, Inc.; Distributed under the GPL
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ppp/ppp-2.4.1-r8.ebuild,v 1.4 2002/07/17 03:11:56 lamer Exp $

  16 Jul 2002; Ben Lutgens <lamer@gentoo.org> ppp-2.4.1-r7.ebuild  :

  16 Jul 2002; Ben Lutgens <lamer@gentoo.org> ppp-2.4.1-r7.ebuild  : :

  updated homepage
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

# modified by Christian Loitsch <gentoo00@loitsch.org>

S=${WORKDIR}/${P}.pppoe4
DESCRIPTION="Point-to-point protocol - patched for pppoe"
SRC_URI="http://www.shoshin.uwaterloo.ca/~mostrows/${P}-pppoe4.tgz"
HOMEPAGE="http://www.samba.org/ppp"

DEPEND="virtual/glibc"
PROVIDE="virtual/pppd"

src_compile() {

	./configure --prefix=/usr || die
    
	#fix Makefiles to compile optimized
	cd pppd
	mv Makefile Makefile.orig
	sed -e "s:COPTS = -O2 -pipe -Wall -g:COPTS = ${CFLAGS}:" \
		-e "s/LIBS =/LIBS = -lcrypt/" \
		Makefile.orig > Makefile
	cd plugins
	mv Makefile Makefile.orig
	sed -e "s:CFLAGS\t= -g -O2:CFLAGS = ${CFLAGS}:" \
		Makefile.orig > Makefile
	cd pppoe
	mv Makefile Makefile.orig
	sed -e "s:CFLAGS\t= -g :CFLAGS = ${CFLAGS}:" \
		Makefile.orig > Makefile
	cd ../../../pppstats
	mv Makefile Makefile.orig
	sed -e "s:COPTS= -O:COPTS = ${CFLAGS}:" \
		Makefile.orig > Makefile
	cd ../chat
	mv Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
	cd ../pppdump
	mv Makefile Makefile.orig
	sed -e "s:CFLAGS= -O:CFLAGS= ${CFLAGS}:" Makefile.orig > Makefile
	cd ..
    
	export CC=gcc
    
	emake || die
}

src_install() {
	for y in chat pppd pppdump pppstats
	do
		doman ${y}/${y}.8
		dosbin ${y}/${y}
	done
    
	chmod u+s-w ${D}/usr/sbin/pppd
	chown root:daemon ${D}/usr/sbin/pppstats
    
	dodir /etc/ppp/peers
	insinto /etc/ppp
	insopts -m0600
	doins etc.ppp/pap-secrets etc.ppp/chap-secrets
	insopts -m0644
	doins etc.ppp/options

	dolib.so pppd/plugins/minconn.so
	dolib.so pppd/plugins/passprompt.so
	dolib.so pppd/plugins/pppoe/pppoe.so
	dodir /usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)
	mv ${D}/usr/lib/*.so ${D}/usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)
	insinto /etc/modules.d
	newins ${FILESDIR}/modules.ppp ppp

	dodoc PLUGINS README* SETUP Changes-2.3 FAQ
	dohtml ${FILESDIR}/pppoe.html

# This will have to be updated to work with the new net.ppp0	
#	# Added a couple scripts to simplify dialing up
#	# borrowed from debian, man they got some nice little apps :-)
#	dosbin ${FILESDIR}/pon
#	dosbin ${FILESDIR}/poff
#	doman  ${FILESDIR}/pon.1
}

pkg_postinst() {
	if [ ! -e ${ROOT}dev/.devfsd ]
	then
		if [ ! -e ${ROOT}dev/ppp ]; then
			mknod ${ROOT}dev/ppp c 108 0
		fi
	fi
	if [ "$ROOT" = "/" ]
	then
		/usr/sbin/update-modules
	fi
	einfo "to enable kernel-pppoe read html/pppoe.html in the doc-directory"
}
