# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rootstrap/rootstrap-0.3.24_p5.ebuild,v 1.1 2010/03/30 00:15:04 jer Exp $

inherit eutils

DESCRIPTION="A tool for building complete Linux filesystem images"
HOMEPAGE="http://packages.qa.debian.org/rootstrap"
SRC_URI="mirror://debian/pool/main/r/${PN}/${PN}_${PV/_p*}.orig.tar.gz
	mirror://debian/pool/main/r/${PN}/${PN}_${PV/_p/-}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-util/debootstrap
	dev-lang/python
	app-arch/dpkg"
DEPEND="${RDEPEND}
	app-text/docbook-sgml-utils"

RESTRICT="test"

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PN}_${PV/_p/-}.diff
	sed -i -e 's:docbook-to-man:docbook2man:' Makefile
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	newdoc debian/changelog ChangeLog
}
