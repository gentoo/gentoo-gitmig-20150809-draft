# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grc/grc-1.3-r1.ebuild,v 1.3 2010/05/24 18:57:21 pacho Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="Generic Colouriser is yet another colouriser for beautifying your logfiles or output of commands"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/grc.html"
SRC_URI="http://kassiopeia.juls.savba.sk/~garabik/software/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

src_prepare() {
	cp -rf "${S}"{,.orig}
	epatch "${FILESDIR}"/1.0.6-support-more-files.patch
	python_convert_shebangs -r 2 .
}

src_install() {
	insinto /usr/share/grc
	doins conf.* "${FILESDIR}"/conf.* || die "share files"
	insinto /etc
	doins grc.conf || die "conf"
	dobin grc grcat || die "dobin"
	dodoc README INSTALL TODO CHANGES CREDITS || die
	doman grc.1 grcat.1 || die
}
