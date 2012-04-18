# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-dl/youtube-dl-2012.02.27.ebuild,v 1.4 2012/04/18 20:13:10 jdhore Exp $

EAPI=3
PYTHON_DEPEND=2:2.5

inherit python

DESCRIPTION="A small command-line program to download videos from YouTube."
HOMEPAGE="http://rg3.github.com/youtube-dl/"
SRC_URI="https://github.com/rg3/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

pkg_setup() { :; }

src_install() {
	newbin rg3-${PN}*/${PN} ${PN} || die
	# Installed with .md to denote markdown format
	dodoc rg3-${PN}*/README.md || die
	python_convert_shebangs -r 2 "${D}"
}
