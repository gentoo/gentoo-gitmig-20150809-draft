# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jasspa-microemacs/jasspa-microemacs-20050505-r3.ebuild,v 1.6 2007/10/10 06:47:18 opfer Exp $

inherit eutils

MY_PV=${PV}	# 20021205 -> 021205

DESCRIPTION="Jasspa Microemacs"
HOMEPAGE="http://www.jasspa.com/"
SRC_URI="http://www.jasspa.com/release_${PV}/jasspa-memacros-${PV}.tar.gz
	http://www.jasspa.com/release_${PV}/jasspa-mehtml-${PV}.tar.gz
	http://www.jasspa.com/release_${PV}/jasspa-mesrc-${PV}.tar.gz
	http://www.jasspa.com/release_${PV}/meicons-extra.tar.gz"
#	http://www.jasspa.com/release_${MY_PV}/me.ehf.gz
#	http://www.jasspa.com/release_${MY_PV}/meicons.tar.gz
##	http://www.jasspa.com/spelling/ls_enus.tar.gz
##	http://www.jasspa.com/release_${MY_PV}/readme.jasspa_gnome

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X"

DEPEND="virtual/libc
	sys-libs/ncurses
	X? ( x11-libs/libX11
			x11-libs/libXt )"

S="${WORKDIR}/me${PV:2}/src"

src_unpack() {
	unpack jasspa-mesrc-${PV}.tar.gz
	cd "${T}"
	# everything except jasspa-mesrc
	unpack ${A/jasspa-mesrc-${PV}.tar.gz/}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-ncurses.patch"
}

src_compile() {
	sed -i "/^COPTIMISE/s/.*/COPTIMISE = ${CFLAGS}/" linux{2,26}.gmk
	local loadpath="~/.jasspa:/usr/share/jasspa/site:/usr/share/jasspa"
	if use X
	then
		./build -p "$loadpath"
	else
		./build -t c -p "$loadpath"
	fi
}

src_install() {
	dodir /usr/share/jasspa
	keepdir /usr/share/jasspa/site
	if use X; then
		newbin me me32 || die
		dobin me || die
	else
		dobin mec || die
		dosym /usr/bin/mec /usr/bin/me
	fi
	dodoc ../*.txt ../change.log
	cp -r "${T}"/* "${D}"/usr/share/jasspa

	insinto /usr/share/applications
	doins "${FILESDIR}/jasspa-microemacs.desktop"
}
