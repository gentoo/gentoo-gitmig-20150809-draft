# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ldapbrowser/ldapbrowser-282_beta2.ebuild,v 1.10 2003/09/05 12:10:36 msterret Exp $

MY_P="Browser282b2"
S=${WORKDIR}/ldapbrowser
DESCRIPTION="Easy management of LDAP directories"
SRC_URI="http://www-unix.mcs.anl.gov/~gawor/ldapcommon/bin/${MY_P}.tar.gz"
HOMEPAGE="http://www.softwareshop.anl.gov/ldapbrowser.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

RDEPEND="virtual/x11
	virtual/jre"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PV}-gentoo.diff
}

src_install() {
	local dirs="lib templates"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done

	cp -a lbe.jar attributes.config ${D}/opt/${P}/
	dobin lbe.sh
	dosym lbe.sh /usr/bin/ldapbrowser
	dodoc CHANGES.TXT LICENSE.ICONS
	dohtml faq.html readme.html relnotes.html help/*
}
