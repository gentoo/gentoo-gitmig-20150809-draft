# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grc/grc-1.4.ebuild,v 1.1 2011/08/24 03:22:20 radhermit Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="Generic Colouriser is yet another colouriser for beautifying your logfiles or output of commands"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/grc.html"
SRC_URI="http://kassiopeia.juls.savba.sk/~garabik/software/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-support-more-files.patch
	python_convert_shebangs -r 2 .
}

src_install() {
	insinto /usr/share/grc
	doins conf.* "${FILESDIR}"/conf.* || die
	insinto /etc
	doins grc.conf || die
	dobin grc grcat || die
	dodoc README INSTALL TODO CHANGES CREDITS || die
	doman grc.1 grcat.1 || die
}
