# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-compat/Encode-compat-0.70.0.ebuild,v 1.1 2011/08/31 10:42:37 tove Exp $

EAPI=4

MODULE_AUTHOR=AUTRIJUS
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="Encode.pm emulation layer"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Text-Iconv"
DEPEND="${RDEPEND}"

#SRC_TEST="do"
