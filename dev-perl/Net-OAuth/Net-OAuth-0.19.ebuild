# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-OAuth/Net-OAuth-0.19.ebuild,v 1.1 2009/10/10 11:07:55 tove Exp $

EAPI=2

MODULE_AUTHOR=KGRENNAN
inherit perl-module

DESCRIPTION="OAuth protocol support"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Class-Accessor-0.31
	>=dev-perl/Class-Data-Inheritable-0.06
	dev-perl/Digest-HMAC
	dev-perl/UNIVERSAL-require
	dev-perl/URI"
DEPEND="${RDEPEND}"

SRC_TEST=do
