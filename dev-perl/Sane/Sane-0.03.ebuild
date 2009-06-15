# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sane/Sane-0.03.ebuild,v 1.2 2009/06/15 09:39:44 dev-zero Exp $

MODULE_AUTHOR=RATCLIFFE
inherit perl-module

DESCRIPTION="The Sane module allows you to access SANE-compatible scanners in a Perl."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=media-gfx/sane-backends-1.0.19"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
