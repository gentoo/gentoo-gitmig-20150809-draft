# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageInfo/ImageInfo-1.30.ebuild,v 1.6 2012/03/25 16:16:24 armin76 Exp $

EAPI=2

MODULE_AUTHOR=SREZIC
MY_PN=Image-Info
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="The Perl Image-Info Module"

SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=dev-perl/IO-String-1.01
	dev-perl/XML-LibXML
	dev-perl/XML-Simple"
RDEPEND="${DEPEND}"

SRC_TEST="do"
