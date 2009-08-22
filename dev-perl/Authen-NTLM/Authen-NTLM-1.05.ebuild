# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-NTLM/Authen-NTLM-1.05.ebuild,v 1.1 2009/08/22 22:09:58 tove Exp $

EAPI=2

MY_PN=NTLM
MY_P=${MY_PN}-${PV}
MODULE_AUTHOR=BUZZ
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="An NTLM authentication module"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=virtual/perl-MIME-Base64-3.00
	dev-perl/Digest-HMAC"
DEPEND="${RDEPEND}"

export OPTIMIZE="$CFLAGS"
