# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-AMF/Data-AMF-0.04.ebuild,v 1.1 2010/07/11 11:29:45 hwoarang Exp $

MODULE_AUTHOR=TYPESTER
inherit perl-module

DESCRIPTION="(de)serializer perl module for Adobe's AMF (Action Message Format)"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/DateTime
	dev-perl/Moose
	dev-perl/UNIVERSAL-require
	dev-perl/XML-LibXML"

SRC_TEST="do"
