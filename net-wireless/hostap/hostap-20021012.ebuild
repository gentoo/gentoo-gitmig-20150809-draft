# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostap/hostap-20021012.ebuild,v 1.3 2003/02/25 19:17:52 latexer Exp $

inherit eutils

DESCRIPTION="HostAP wireless drivers"
HOMEPAGE="http://hostap.epitest.fi/"

PCMCIA_VERSION="`cardmgr -V 2>&1 | cut -f3 -d' '`"
MY_PCMCIA="pcmcia-cs-${PCMCIA_VERSION}"
SRC_URI="http://hostap.epitest.fi/releases/${PN}-2002-10-12.tar.gz
		pcmcia? ( mirror://sourceforge/pcmcia-cs/${MY_PCMCIA}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="pcmcia"

DEPEND=">=net-wireless/wireless-tools-25
		pcmcia? ( >=sys-apps/pcmcia-cs-3.2.1* )"

S=${WORKDIR}/${PN}-2002-10-12
LIB_PATH="/lib/modules/`uname -r`"

src_unpack() {
	unpack ${A}
	cd ${S}

	# This is a patch that has already been applied to the hostap
	# cvs tree. It fixes hostapd compilation for gcc-3.2

	epatch ${FILESDIR}/${P}-gentoo-patch.diff

	cp Makefile ${T}
	sed -e "s:^PCMCIA_PATH=:PCMCIA_PATH=${WORKDIR}/${MY_PCMCIA}:" \
		-e "s:gcc:${CC}:" \
		-e "s:-O2:${CFLAGS}:" \
		-e "s:\$(EXTRA_CFLAGS):\$(EXTRA_CFLAGS) -DPRISM2_HOSTAPD:" \
		${T}/Makefile > Makefile
	
	cd ${S}/hostapd
	cp Makefile ${T}
	sed -e "s:gcc:${CC}:" \
		-e "s:-O2:${CFLAGS}:" \
		${T}/Makefile > Makefile
}

src_compile() {
	
	HOSTAP_DRIVERS="pci plx"

	use pcmcia && HOSTAP_DRIVERS="${HOSTAP_DRIVERS} pccard"

	emake ${HOSTAP_DRIVERS} hostap crypt || die

	cd ${S}/hostapd
	emake || die
}

src_install() {
	if [ -n "`use pcmcia`" ]; then
		dodir ${LIB_PATH}/pcmcia
		dodir /etc/pcmcia
		cp ${S}/driver/modules/hostap_cs.o ${D}/${LIB_PATH}/pcmcia/
		cp ${S}/driver/etc/hostap_cs.conf ${D}/etc/pcmcia/
		if [ -r /etc/pcmcia/prism2.conf ]; then
			einfo "You may need to remove /etc/pcmcia/prism2.conf"
		fi
	fi

	dodir ${LIB_PATH}/net
	cp ${S}/driver/modules/{hostap.o,hostap_crypt.o,hostap_crypt_wep.o}\
		${D}${LIB_PATH}/net/
	cp ${S}/driver/modules/{hostap_pci.o,hostap_plx.o}\
		${D}${LIB_PATH}/net/

	dodoc FAQ README README.prism2 ChangeLog

	dosbin hostapd/hostapd
}

	
		
