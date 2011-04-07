# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-NTLM/Authen-NTLM-1.80.0.ebuild,v 1.1 2011/04/07 11:32:16 tove Exp $

EAPI=2

MY_PN=NTLM
MODULE_AUTHOR=NBEBOUT
MODULE_VERSION=1.08
inherit perl-module

DESCRIPTION="An NTLM authentication module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=">=virtual/perl-MIME-Base64-3.00
	dev-perl/Digest-HMAC"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
	)"

SRC_TEST=do
export OPTIMIZE="$CFLAGS"
