# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-console/vmware-console-3.1.0.9089.ebuild,v 1.5 2005/03/23 18:35:58 seemant Exp $

MY_PN="VMware-console"
MY_PV=${PV%.*}-${PV##*.}
MY_P="${MY_PN}-${MY_PV}"
FN="${MY_P}.tar.gz"
S="${WORKDIR}/vmware-console-distrib"

DESCRIPTION="VMware Remote Console for Linux"
HOMEPAGE="http://www.vmware.com/"
SRC_URI="${FN}"

LICENSE="vmware"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch nostrip"
IUSE="esx"

DEPEND="virtual/libc
	virtual/x11"

pkg_nofetch() {
	einfo "Please obtain ${FN} and place it in ${DISTDIR}"
}

src_install () {
	# Set up config database
	echo 'libdir = "/opt/vmware-console/lib"' >etc/config
	cat >etc/locations <<EOF
file /opt/vmware-console/etc/locations
answer BINDIR /opt/vmware-console/bin
answer LIBDIR /opt/vmware-console/lib
answer DOCDIR /usr/share/doc/${P}
answer MANDIR /usr/share/man
file /opt/vmware-console/etc/not_configured 1085493247
file /opt/vmware-console/etc/config 1085493247
EOF

	# Install docs and man pages
	dodoc doc/*
	find man -name \*.\?.gz | xargs doman
	dohtml -r lib/help lib/help-guestinstall lib/help-manual
	wd=`pwd`
	cd ${D}/usr/share/doc/${P}/html
	for i in help help-guestinstall help-manual; do
		cd $i
		if use esx; then
			for j in esx/*; do
				ln -s $j
			done
		else
			for j in gsx/*; do
				ln -s $j
			done
		fi
		cd ..
	done
	cd ${wd}

	# Install everything else
	into /opt/vmware-console
	dobin bin/*
	dodir /opt/vmware-console/etc
	cp -dr etc/* ${D}/opt/vmware-console/etc/
	dodir /etc
	dosym /opt/vmware-console/etc /etc/vmware-console

	# Setup environment to include our bin directory in the PATH
	insinto /etc/env.d
	doins ${FILESDIR}/99vmware-console

	# We already installed the HTML docs, so we can use symlinks
	dodir /opt/vmware-console/lib
	rm -rf lib/help lib/help-guestinstall lib/help-manual
	cp -dr lib/* ${D}/opt/vmware-console/lib/
	dosym /usr/share/doc/${P}/html/help /opt/vmware-console/lib/help
	dosym /usr/share/doc/${P}/html/help /opt/vmware-console/lib/help-guestinstall
	dosym /usr/share/doc/${P}/html/help /opt/vmware-console/lib/help-manual
}

pkg_postinst() {
	if use esx; then
		echo
		ewarn "By setting the 'esx' USE flag, the documentation that is accessed from the Help menu will be for ESX Server"
		ewarn "You can still access the GSX Server documentation in /usr/share/doc/${P}/html"
		echo
	else
		echo
		ewarn "The documentation that is accessed from the Help menu will be for GSX Server"
		ewarn "You may select ESX Server documentation by setting the 'esx' USE flag"
		ewarn "You can still access the ESX Server documentation in /usr/share/doc/${P}/html"
		echo
	fi
}
