# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/parallels-workstation/parallels-workstation-2.2.2112-r2.ebuild,v 1.3 2009/08/22 23:22:09 williamh Exp $

inherit eutils

S=${WORKDIR}/parallels-${PV}-lin
DESCRIPTION="Virtual machine software that runs multiple operating systems and their applications simultaneously on a single PC."
HOMEPAGE="http://www.parallels.com"
SRC_URI="http://download.parallels.com/GA/Parallels-${PV}-lin.tgz"

LICENSE="Parallels"
SLOT="0"
KEYWORDS="-* ~x86"
RESTRICT="strip"

DEPEND="virtual/os-headers
	=x11-libs/qt-3*
	~virtual/libstdc++-3.3"

destdir=/usr/lib/parallels

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-2.2.2112-2.6.23.patch
}

src_install() {
	dodoc data/doc/README data/doc/INSTALL data/doc/LICENSE

	dodir ${destdir}/doc
	insinto ${destdir}/doc
	doins data/doc/README data/doc/INSTALL data/doc/LICENSE

	insinto ${destdir}
	doins data/*

	dodir ${destdir}/bugreports
	fperms 1777 ${destdir}/bugreports

	touch ${destdir}/.parallels_common_options
	fperms 666 ${destdir}/.parallels_common_options
	touch ${destdir}/.parallels_license
	fperms 666 ${destdir}/.parallels_license
	touch ${destdir}/.not_configured

	dosym ${destdir}/parallels /usr/bin/parallels
	dosym ${destdir}/imagetool /usr/bin/imagetool
	dosym ${destdir}/parallels-config /usr/bin/parallels-config

	dosym /usr/bin/parallels /usr/bin/Parallels
	dosym /usr/bin/parallels-config /usr/bin/Parallels-config

	newinitd "${FILESDIR}"/parallels.rc parallels
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
	elog "You should configure ${PN} ${PV}"
	elog "before starting it for the first time."
	elog "Issue \"parallels-config\" command."
	echo
}

pkg_postrm() {
	if [ -e $destdir/Makefile ]; then
		make -C $destdir clean distclean > /dev/null 2>&1
	fi
}
