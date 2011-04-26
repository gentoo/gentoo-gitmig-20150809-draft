# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SMIME/Crypt-SMIME-0.10.ebuild,v 1.2 2011/04/26 15:10:44 mr_bones_ Exp $

EAPI="3"

MODULE_AUTHOR="MIKAGE"

inherit perl-module

DESCRIPTION="S/MIME sign, verify, encrypt and decrypt"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-libs/openssl"
DEPEND="${RDEPEND}
	dev-perl/Test-Exception"
