# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit perl-module

S=${WORKDIR}/NTLM-${PV}
DESCRIPTION="An NTLM authentication module"
SRC_URI="http://cpan.org/modules/by-module/Authen/NTLM-${PV}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Authen/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"
RDEPEND=">=dev-perl/MIME-Base64-3.00"

export OPTIMIZE="$CFLAGS"

