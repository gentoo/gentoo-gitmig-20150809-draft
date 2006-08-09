# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tinyos/tos-apps/tos-apps-1.1.15.ebuild,v 1.2 2006/08/09 19:48:55 sanchan Exp $
inherit eutils

CVS_MONTH="Dec"
CVS_YEAR="2005"
MY_PN="tinyos"
MY_P=${MY_PN}-${PV}${CVS_MONTH}${CVS_YEAR}cvs

DESCRIPTION="TinyOS apps: TinyOS bundled applications."
HOMEPAGE="http://www.tinyos.net/"
SRC_URI="http://www.tinyos.net/dist-1.1.0/tinyos/source/${MY_P}.tar.gz"
LICENSE="Intel"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-tinyos/tos-1.1.15"
RDEPEND=">=dev-tinyos/tos-make-1.1.15"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if [ -z "${TOSROOT}" ]
	then
		export TOSROOT=/usr/src/tinyos-1.x
	fi

	if [ ! -d "${TOSROOT}" ]
	then
		eerror "In order to emerge tos-apps you have to set the"
		eerror "\$TOSROOT environment properly."
		eerror ""
		eerror "You can achieve this by emerging >=dev-tinyos/tos-1.1.15"
		eerror "or by exporting TOSDIR=\"path to your tinyos dir\""
		die "Couldn't find a valid TinyOS home"
	else
		einfo "Building tos-apps for ${TOSROOT}"
	fi
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	insinto ${TOSROOT}
	doins -r apps
	chown -R root:0 "${D}"
}

pkg_postinst() {
	elog "If you want to use TinyOS on real hardware you need a cross compiler."
	elog "You should emerge sys-devel/crossdev and compile any toolchain you need"
	elog "Example: for Mica2 and Mica2 Dot: crossdev --target avr"
	ebeep 5
	epause 5
}

