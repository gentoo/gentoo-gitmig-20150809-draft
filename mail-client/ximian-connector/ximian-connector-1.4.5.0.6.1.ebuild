# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/ximian-connector/ximian-connector-1.4.5.0.6.1.ebuild,v 1.5 2004/07/14 16:35:55 agriffis Exp $

inherit rpm gnome2

DESCRIPTION="Ximian Connector (An Evolution Plugin to talk to Exchange Servers)"
HOMEPAGE="http://www.ximian.com"

IUSE="krb4"
LICENSE="Ximian-Connector"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha -mips"
RESTRICT="nomirror fetch nostrip"

# there doesn't seem to be one for ppc anymore
XIMIAN_DIST="redhat-90-i386"
XIMIAN_ARCH="i386"

# make the ximian rev from the package version
# bash magic to extract last 2 versions as XIMIAN_V,
# third last version as RPM_V and the rest as MY_PV
MY_PV=${PV%.[0-9]*.[0-9]*.[0-9]*}
END_V=${PV/${MY_PV}./}
RPM_V=${END_V%.[0-9]*.[0-9]*}
XIMIAN_V=${END_V#[0-9]*.}

SRC_URI="${PN}-${MY_PV}-${RPM_V}.ximian.${XIMIAN_V}.${XIMIAN_ARCH}.rpm"

RDEPEND="=mail-client/evolution-${MY_PV}*
	>=gnome-extra/gal-1.99.10
	>=app-crypt/mit-krb5-1.2"
DEPEND=""

S=${WORKDIR}

pkg_setup() {
	if ! use krb4; then
		eerror "Ximian Connector requires Kerberos 4 support in app-crypt/mit-krb5."
		eerror "You will need to remerge it by executing:"
		eerror ""
		eerror "USE='krb4' emerge mit-krb5 ximian-connector"
		die "missing kerberos 4 support"
	fi
}

pkg_nofetch() {
	einfo "This package requires that you download the rpm from:"
	einfo "http://ximian.com/products/connector/download/download.html"
	einfo "and place it in ${DISTFILES}."
	einfo ""
	einfo "NOTE: x86 users should download the package for ${XIMIAN_ARCH}"
#	einfo "      ppc users should download the package for yellowdog-22-ppc"
}

src_compile() {
	return;
}

src_install() {
	cp -dpR * ${D}
}

pkg_postinst(){
	gnome2_gconf_install
	einfo "NOTE: Ximian connector requires the purchase of a"
	einfo "key from Ximian to function properly."
}
