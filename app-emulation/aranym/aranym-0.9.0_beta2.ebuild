# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/aranym/aranym-0.9.0_beta2.ebuild,v 1.1 2005/03/08 22:21:43 dholm Exp $

inherit flag-o-matic eutils

MY_PV="0.9.0beta2"
AFROS="afros-200502026.zip"
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="Atari Running on Any Machine, is a virtual machine software for running Atari ST/TT/Falcon operating systems and TOS/GEM applications"
HOMEPAGE="http://aranym.sourceforge.net/"
SRC_URI="mirror://sourceforge/aranym/${PN}-${MY_PV}.tar.gz
	mirror://sourceforge/aranym/${AFROS}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="opengl"

DEPEND="media-libs/libsdl
	games-emulation/emutos
	app-arch/unzip
	opengl? ( virtual/opengl )
	>=sys-apps/sed-4"

src_unpack() {
	unpack "${PN}-${MY_PV}.tar.gz"
}

src_compile() {
	filter-flags -mpowerpc-gfxopt

	use opengl && myconf="--enable-opengl"
	if [ "${ARCH}" = "x86" ]; then
		myconf="${myconf} --enable-jit-compiler"
	fi

	cd ${S}/src/Unix
	econf ${myconf} || die "configure failed"

	emake dep || die "failed while building dependencies"
	emake || die "failed during compilation"
}

src_install() {
	cd ${S}/src/Unix
	emake DESTDIR=${D} install || die "installation failed"

	dosym /usr/games/lib/etos512k.img /usr/share/aranym

	cd ${D}/usr/share/aranym
	unzip ${DISTDIR}/${AFROS}
	sed -i -e "s|tmp|usr/share/aranym|g" ${D}/usr/share/aranym/afros/config
}

pkg_postinst() {
	einfo "To run ARAnyM with AFROS type: aranym --config /usr/share/aranym/afros/config"
}
