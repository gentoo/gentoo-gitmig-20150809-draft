# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/aranym/aranym-0.9.7_beta.ebuild,v 1.1 2009/01/30 00:21:06 dirtyepic Exp $

inherit flag-o-matic eutils

MY_PV="${PV/_/}"
AFROS="afros812.zip"
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="Atari Running on Any Machine, is a virtual machine software for running Atari ST/TT/Falcon operating systems and TOS/GEM applications"
HOMEPAGE="http://aranym.sourceforge.net/"
SRC_URI="mirror://sourceforge/aranym/${PN}-${MY_PV}.tar.gz
	mirror://sourceforge/aranym/${AFROS}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="opengl"

RDEPEND="media-libs/libsdl
	games-emulation/emutos
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${PN}-${MY_PV}.tar.gz
	cd "${S}"
}

src_compile() {
	filter-flags -mpowerpc-gfxopt

	use opengl && myconf="--enable-opengl"
	if [[ ${ARCH} == x86 ]]; then
		myconf="${myconf} --enable-jit-compiler"
	fi

	econf ${myconf} || die "configure failed"
	emake || die "failed during compilation"
}

src_install() {
	emake DESTDIR="${D}" INSTALL_PROGRAM="install" install || die "installation failed"

	dosym /usr/games/lib/etos512k.img /usr/share/aranym

	cd "${D}"/usr/share/aranym
	unzip "${DISTDIR}/${AFROS}"

	find . -type f -perm -o+w -print0 | xargs -0 fperms o-w

	sed -i -e "s|tmp|usr/share/aranym|g" "${D}"/usr/share/aranym/afros/config
}

pkg_postinst() {
	elog "To run ARAnyM with AFROS type: aranym --config /usr/share/aranym/afros/config"
}
