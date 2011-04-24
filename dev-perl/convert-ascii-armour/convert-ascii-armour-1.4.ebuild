# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/convert-ascii-armour/convert-ascii-armour-1.4.ebuild,v 1.25 2011/04/24 15:52:07 grobian Exp $

inherit perl-module

MY_P=Convert-ASCII-Armour-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Convert binary octets into ASCII armoured messages."
HOMEPAGE="http://search.cpan.org/~vipul/"
SRC_URI="mirror://cpan/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ~ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="virtual/perl-IO-Compress
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
	dev-lang/perl"
