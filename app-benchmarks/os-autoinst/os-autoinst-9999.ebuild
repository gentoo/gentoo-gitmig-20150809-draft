# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/os-autoinst/os-autoinst-9999.ebuild,v 1.1 2012/03/14 14:30:34 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="git://gitorious.org/os-autoinst/os-autoinst.git"

inherit git-2 autotools

DESCRIPTION="automated testing of Operating Systems"
HOMEPAGE="http://os-autoinst.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-emulation/qemu-kvm
	app-text/gocr
	media-gfx/imagemagick
	media-video/ffmpeg2theora

"
DEPEND=""

src_prepare() {
	epatch \
		"${FILESDIR}/0001-use-proper-path-to-share-for-isotovideo.patch" \
		"${FILESDIR}/0002-Use-libexecdir-and-do-not-depend-on-runtime-deps.patch"

	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}
