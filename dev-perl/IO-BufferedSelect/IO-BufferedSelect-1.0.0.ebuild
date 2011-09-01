# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-BufferedSelect/IO-BufferedSelect-1.0.0.ebuild,v 1.2 2011/09/01 16:32:19 tove Exp $

EAPI=4

MODULE_AUTHOR=AFN
MODULE_VERSION=1.0
inherit perl-module

DESCRIPTION="Perl module that implements a line-buffered select interface"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${PN}"
