# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/aranym/aranym-0.9.0.ebuild,v 1.2 2007/01/25 21:55:49 genone Exp $

inherit flag-o-matic eutils

AFROS="afros-20050424.zip"
DESCRIPTION="Atari Running on Any Machine, is a virtual machine software for running Atari ST/TT/Falcon operating systems and TOS/GEM applications"
HOMEPAGE="http://aranym.sourceforge.net/"
SRC_URI="mirror://sourceforge/aranym/${P}.tar.gz
	mirror://sourceforge/aranym/${AFROS}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"  # At the moment it doesn't compile due to our linux-headers
IUSE="opengl"

RDEPEND="media-libs/libsdl
	games-emulation/emutos
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${P}.tar.gz
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
	elog "To run ARAnyM with AFROS type: aranym --config /usr/share/aranym/afros/config"
}
