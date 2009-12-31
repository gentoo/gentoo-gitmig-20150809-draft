# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/flite/flite-1.4.ebuild,v 1.1 2009/12/31 21:31:39 williamh Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Flite text to speech engine"
HOMEPAGE="http://www.speech.cs.cmu.edu/flite/index.html"
SRC_URI=" http://www.speech.cs.cmu.edu/${PN}/packed/${P}/${P}-release.tar.bz2"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa oss"

S=${WORKDIR}/${P}-release

get_audio() {
	if use alsa; then
		echo alsa
	elif use oss; then
		echo oss
	else
		echo none
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-respect-destdir.patch
}

src_configure() {
	econf \
		--with-audio=$(get_audio) || die "configuration failed"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "Failed compilation"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	dodoc ACKNOWLEDGEMENTS README
}

pkg_postinst() {
	if [ "$(get_audio)" = "none" ]; then
		ewarn "you have built flite without audio support."
		ewarn "If you want audio support for flite, you need"
		ewarn "alsa or oss in your use flags."
	fi
}
