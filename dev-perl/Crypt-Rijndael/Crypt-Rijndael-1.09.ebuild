# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Rijndael/Crypt-Rijndael-1.09.ebuild,v 1.1 2010/01/23 10:32:53 tove Exp $

EAPI=2

MODULE_AUTHOR=BDFOY
inherit perl-module

DESCRIPTION="Crypt::CBC compliant Rijndael encryption module"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
