# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-ListDetector/Mail-ListDetector-1.40.ebuild,v 1.1 2011/02/20 07:56:19 tove Exp $

EAPI=3

MODULE_AUTHOR=MSTEVENS
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="Perl extension for detecting mailing list messages"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/URI
	dev-perl/Email-Valid
	dev-perl/Email-Abstract"
DEPEND="${RDEPEND}"

SRC_TEST="do"
