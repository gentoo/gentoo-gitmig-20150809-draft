# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sane/Sane-0.30.0.ebuild,v 1.1 2011/08/29 09:29:44 tove Exp $

EAPI=4

MODULE_AUTHOR=RATCLIFFE
MODULE_VERSION=0.03
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
