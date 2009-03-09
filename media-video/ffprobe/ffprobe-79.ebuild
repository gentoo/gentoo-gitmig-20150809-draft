# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffprobe/ffprobe-79.ebuild,v 1.3 2009/03/09 14:08:14 armin76 Exp $

inherit autotools

DESCRIPTION="Tool to probe audio / video using ffmpeg and print pretty output"
HOMEPAGE="http://sourceforge.net/projects/ffprobe/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="perl"

DEPEND="media-video/ffmpeg"
RDEPEND="${DEPEND}
	perl? ( virtual/perl-Scalar-List-Utils
		virtual/perl-Getopt-Long
		virtual/perl-File-Spec
		dev-perl/Statistics-Descriptive
		sci-visualization/gnuplot )"

src_unpack() {

	unpack ${A}
	cd "${S}"

	einfo "Regenerating autotools files..."
	eautoconf || die "eautoconf failed"

}

src_install() {

	dobin src/ffprobe
	if use perl; then
		newbin tools/plot-vframes-bitrate.pl plot-vframes-bitrate
		newbin tools/plot-vframes-sizes.pl plot-vframes-sizes
	fi
	doman doc/ffprobe.1
	dohtml doc/ffprobe.html
	dodoc AUTHORS README

}

pkg_postinst() {

	einfo "ffprobe with no arguments doesn't produce anything interesting"
	einfo "other than the same output you would get with ffmpeg -i"
	einfo "See -h for output options."

}
