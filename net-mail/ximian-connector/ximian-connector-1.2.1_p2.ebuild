# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ximian-connector/ximian-connector-1.2.1_p2.ebuild,v 1.2 2003/02/13 14:44:30 vapier Exp $

DESCRIPTION="Ximian Connector (An Evolution Plugin to talk to Exchange Servers)"
HOMEPAGE="http://www.ximian.com"
LICENSE="Ximian-Connector"
SLOT="0"
KEYWORDS="~ppc -sparc -alpha"
RESTRICT="fetch nostrip"

XIMIAN_ARCH="blargh"
XIMIAN_DIST="frobs"

if [ `use ppc` ]; then
	XIMIAN_DIST="yellowdog-22-ppc"
	XIMIAN_ARCH="ppc"
elif [ `use x86` ]; then
	XIMIAN_DIST="redhat-73-i386"
	XIMIAN_ARCH="i386"
fi

# make the ximian rev from the package version
# 1.2.1_p2 should result in 1.2.1-2
XIMIAN_REV=`echo ${PV} | sed -e "s/_p/-/"`

SRC_URI="${PN}-${XIMIAN_REV}.ximian.1.${XIMIAN_ARCH}.rpm"

DEPEND="app-arch/rpm2targz
        >=net-mail/evolution-1.2.1*"
RDEPEND=">=net-mail/evolution-1.2.1*"

pkg_setup() {
        if [ "${ARCH}" != "x86" -a "${ARCH}" != "ppc" ]
		then
                einfo "This package is only available for x86 and ppc, sorry"
                die "Not supported on your ARCH"
        fi
}

src_unpack() {
	if [ ! -f ${DISTDIR}/${SRC_URI} ]
	then
			einfo
			einfo "Please download ${SRC_URI} from Ximian's website"
			einfo "The script at http://cvs.gentoo.org/~nall/get_connector.py"
			einfo "might be useful."
			einfo 
			einfo "after it downloads, place the rpm in ${DISTDIR}"
			einfo "NOTE: Ximian connector requires the purchase of a"
			einfo "key from Ximian to function properly."
			einfo
			die
	fi

	rpm2targz ${DISTDIR}/${A}
	mv ${WORKDIR}/${PN}-${XIMIAN_REV}.ximian.1.${XIMIAN_ARCH}.tar.gz ${DISTDIR}
	unpack ${PN}-${XIMIAN_REV}.ximian.1.${XIMIAN_ARCH}.tar.gz
}

src_install() {
	cd ${WORKDIR}
	cp -dpR * ${D}
	dosym /usr/lib/libssl.so /usr/lib/libssl.so.2
	dosym /usr/lib/libcrypto.so /usr/lib/libcrypto.so.2
}
