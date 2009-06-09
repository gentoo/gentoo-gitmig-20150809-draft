# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Duration-Parse/Time-Duration-Parse-0.06.ebuild,v 1.1 2009/06/09 20:16:47 tove Exp $

EAPI=2

MODULE_AUTHOR=MIYAGAWA
inherit perl-module

DESCRIPTION="Parse string that represents time duration"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-perl/Exporter-Lite
	dev-perl/Time-Duration"
DEPEND="${RDEPEND}"

SRC_TEST=do
