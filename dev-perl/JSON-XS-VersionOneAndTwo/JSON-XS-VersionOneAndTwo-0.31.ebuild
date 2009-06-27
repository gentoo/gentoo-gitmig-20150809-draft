# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-XS-VersionOneAndTwo/JSON-XS-VersionOneAndTwo-0.31.ebuild,v 1.1 2009/06/27 07:10:16 tove Exp $

EAPI=2

MODULE_AUTHOR=LBROCARD
inherit perl-module

DESCRIPTION="Support versions 1 and 2 of JSON::XS"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/JSON-XS"
DEPEND="test? ( ${RDEPEND}
	dev-perl/Test-Pod )"

SRC_TEST=do
