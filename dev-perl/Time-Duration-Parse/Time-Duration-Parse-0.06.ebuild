# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Duration-Parse/Time-Duration-Parse-0.06.ebuild,v 1.2 2009/07/03 06:21:17 tove Exp $

EAPI=2

MODULE_AUTHOR=MIYAGAWA
inherit perl-module

DESCRIPTION="Parse string that represents time duration"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Exporter-Lite
	dev-perl/Time-Duration"
DEPEND="${RDEPEND}"

SRC_TEST=do
