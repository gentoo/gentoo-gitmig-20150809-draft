# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/aranym/aranym-0.8.6_beta.ebuild,v 1.2 2004/02/11 10:19:17 dholm Exp $

inherit flag-o-matic

AFROS="afros-20040206.zip"
S="${WORKDIR}/${PN}-0.8.6beta"
DESCRIPTION="ARAnyM is a virtual machine software for running the Atari ST/TT/Falcon operating systems (TOS, FreeMiNT, MagiC and others) and TOS/GEM applications."
SRC_URI="mirror://sourceforge/aranym/${PN}-0.8.6beta.tar.gz
	mirror://sourceforge/aranym/${AFROS}"
HOMEPAGE="http://aranym.sourceforge.net/"
LICENSE="GPL-2"

KEYWORDS="~ppc"
SLOT="0"

IUSE="sdl"
DEPEND="media-libs/libsdl
	games-emulation/emutos
	app-arch/unzip
	opengl? virtual/opengl"

src_unpack() {
	unpack "${PN}-0.8.6beta.tar.gz"
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

src_install () {
	cd ${S}/src/Unix
	emake DESTDIR=${D} install || die "installation failed"

	dosym /usr/games/lib/etos512k.img /usr/share/aranym

	cd ${D}/usr/share/aranym
	unzip ${DISTDIR}/${AFROS}
	sed -i -e "s|tmp|usr/share/aranym|g" ${D}/usr/share/aranym/afros/config
}

pkg_postinst() {
	einfo "To run ARAnyM with AFROS type: aranym -c /usr/share/aranym/afros/config"
}

