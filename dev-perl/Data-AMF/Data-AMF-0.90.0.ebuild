# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-AMF/Data-AMF-0.90.0.ebuild,v 1.1 2011/08/31 13:26:49 tove Exp $

EAPI=4

MODULE_AUTHOR=TYPESTER
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="(de)serializer perl module for Adobe's AMF (Action Message Format)"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/DateTime
	dev-perl/Any-Moose
	dev-perl/UNIVERSAL-require
	dev-perl/XML-LibXML"

DEPEND="${RDEPEND}
	test? ( dev-perl/yaml )"

SRC_TEST="do"
