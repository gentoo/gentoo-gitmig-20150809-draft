# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/parallels-workstation/parallels-workstation-2.2.2112-r1.ebuild,v 1.2 2007/07/02 14:00:27 peper Exp $

inherit eutils

S=${WORKDIR}/parallels-${PV}-lin
DESCRIPTION="Virtual machine software that runs multiple operating systems and their applications simultaneously on a single PC."
HOMEPAGE="http://www.parallels.com"
SRC_URI="http://download.parallels.com/GA/Parallels-${PV}-lin.tgz"

LICENSE="Parallels"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="strip"

DEPEND="virtual/os-headers
	=x11-libs/qt-3*
	>=sys-libs/libstdc++-v3-3.0.0
"
destdir=/usr/lib/parallels

src_unpack() {
	unpack Parallels-${PV}-lin.tgz
	cd ${S}
	epatch "${FILESDIR}"/${PN}-2.2.2112-prlnet.patch
}

src_install() {
	dodir ${destdir}/doc

	dodoc ${S}/data/doc/README ${S}/data/doc/INSTALL ${S}/data/doc/LICENSE
	cp -a ${S}/data/doc/README ${D}/${destdir}/doc
	cp -a ${S}/data/doc/INSTALL ${D}/${destdir}/doc
	cp -a ${S}/data/doc/LICENSE ${D}/${destdir}/doc

	cp -a ${S}/data/* ${D}/${destdir}

	dodir ${destdir}/bugreports; fperms 1777 ${destdir}/bugreports

	touch ${D}/${destdir}/.parallels_common_options; fperms	666 ${destdir}/.parallels_common_options
	touch ${D}/${destdir}/.parallels_license; fperms 666 ${destdir}/.parallels_license
	touch ${D}/${destdir}/.not_configured

	dodir /usr/bin/
	dosym ${destdir}/parallels /usr/bin/parallels
	dosym ${destdir}/imagetool /usr/bin/imagetool
	dosym ${destdir}/parallels-config /usr/bin/parallels-config

	dosym /usr/bin/parallels /usr/bin/Parallels
	dosym /usr/bin/parallels-config /usr/bin/Parallels-config

	newinitd ${FILESDIR}/parallels.rc parallels
}

pkg_preinst() {
	running=`rc-status -s | grep parallels | grep started`
	if [[ $running != "" ]]; then
		/etc/init.d/parallels stop
	fi
}

pkg_postinst() {
	rm -f $destdir/.ereaded

	$destdir/tools/mimelink associate 2> /dev/null
	chmod 06555 $destdir/parallels-linux

	echo
	einfo "You should configure ${PN} ${PV}"
	einfo "before starting it for the first time."
	einfo "Issue \"parallels-config\" command."
	echo
}

pkg_postrm() {
	if [ -e $destdir/Makefile ]; then
		make -C $destdir clean distclean > /dev/null 2>&1
	fi
}
