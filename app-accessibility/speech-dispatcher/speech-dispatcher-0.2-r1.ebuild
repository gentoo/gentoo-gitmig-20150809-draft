# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.2-r1.ebuild,v 1.1 2004/04/03 20:04:38 eradicator Exp $

inherit eutils libtool

MY_PN="speechd"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="speech-dispatcher speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="dev-libs/dotconf
	>=app-accessibility/flite-1.2
	>=dev-libs/glib-2
	media-libs/alsa-lib"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.8
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}

	cd ${S}
	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5

	epatch ${FILESDIR}/speech-dispatcher-${PV}-gentoo.patch
	autoreconf || die "Could not update configure script with autoconf/automake"
	elibtoolize
}

src_install() {
	make DESTDIR=${D} install || die

	mv ${D}/usr/bin/speechd ${D}/usr/bin/speech-dispatcher

	exeinto /etc/init.d
	doexe ${FILESDIR}/speech-dispatcher

	insinto /usr/include
	doins ${S}/src/c/api/libspeechd.h
}

pkg_postinst() {
	echo
	einfo "To enable Festival support, you must install app-accessibility/festival-freebsoft-utils."
	echo
}
