# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LWP-Protocol-https/LWP-Protocol-https-6.20.0.ebuild,v 1.3 2011/04/08 16:02:02 maekke Exp $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.02
inherit perl-module

DESCRIPTION="Provide https support for LWP::UserAgent"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/${CATEGORY}/${PN}/${PN}_ca-cert.patch.gz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~arm ~hppa ~x86"

RDEPEND="
	app-misc/ca-certificates
	>=dev-perl/libwww-perl-6.20.0
	>=dev-perl/Net-HTTP-6
	>=dev-perl/IO-Socket-SSL-1.38
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

PATCHES=( "${WORKDIR}"/${PN}_ca-cert.patch )

SRC_TEST=online
