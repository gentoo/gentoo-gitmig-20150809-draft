# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.9.10-r1.ebuild,v 1.8 2003/06/18 13:56:02 seemant Exp $

IUSE="ssl"

S="${WORKDIR}/${PN}"

DESCRIPTION="Open Source implementation of the ITU H.323 teleconferencing protocol"
HOMEPAGE="http://www.openh323.org"
SRC_URI="http://www.openh323.org/bin/${PN}_${PV}.tar.gz"

DEPEND="media-libs/speex
	>=dev-libs/pwlib-1.3.11-r1
	ssl? ( dev-libs/openssl )"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 ppc sparc"

src_compile() {
	export PWLIBDIR=/usr/share/pwlib
	export OPENH323DIR=${S}

	if [ "`use ssl`" ]; then
		export OPENSSLFLAG=1
		export OPENSSLDIR=/usr
		export OPENSSLLIBS="-lssl -lcrypt"
	fi

	make optshared || die
}

src_install() {
	dodir /usr/share/openh323

	into /usr
	dolib ${S}/lib/lib*

	cd ${S}
	find ./ -name 'CVS' | xargs rm -f
	cp -a * ${D}/usr/share/openh323

	if [ ${ARCH} = "ppc" ] ; then
		dosym libh323_linux_ppc_r.so.${PV} /usr/lib/libopenh323.so
	else
		dosym libh323_linux_x86_r.so.${PV} /usr/lib/libopenh323.so
	fi
}
