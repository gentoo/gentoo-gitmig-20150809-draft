# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/flite/flite-1.4-r1.ebuild,v 1.4 2012/04/13 20:24:43 neurogeek Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Flite text to speech engine"
HOMEPAGE="http://www.speech.cs.cmu.edu/flite/index.html"
SRC_URI=" http://www.speech.cs.cmu.edu/${PN}/packed/${P}/${P}-release.tar.bz2"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 -hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa oss static-libs"

DEPEND="alsa? ( >=media-libs/alsa-lib-1.0.24.1 )"
RDEPEND="${DEPEND}"

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
	epatch "${FILESDIR}"/${P}-fix-parallel-builds.patch
	epatch "${FILESDIR}"/${P}-respect-destdir.patch
	epatch "${FILESDIR}"/${P}-ldflags.patch
	sed -i main/Makefile \
		-e '/-rpath/s|$(LIBDIR)|$(INSTALLLIBDIR)|g' \
		|| die
}

src_configure() {
	local myconf
	if ! use static-libs; then
		myconf=--enable-shared
	fi
	myconf="${myconf} --with-audio=$(get_audio)"
	econf ${myconf} || die "configuration failed"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	dodoc ACKNOWLEDGEMENTS README || die "Documentation installation failed"
	if ! use static-libs; then
		rm -rf "${D}"/usr/lib*/*.a
	fi
}

pkg_postinst() {
	if [ "$(get_audio)" = "none" ]; then
		ewarn "you have built flite without audio support."
		ewarn "If you want audio support, re-emerge"
		ewarn "flite with alsa or oss in your use flags."
	fi
}
