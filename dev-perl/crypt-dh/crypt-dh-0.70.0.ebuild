# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-dh/crypt-dh-0.70.0.ebuild,v 1.2 2012/10/11 14:24:32 ago Exp $

EAPI=4

MY_PN=Crypt-DH
MODULE_AUTHOR=MITHALDU
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="Diffie-Hellman key exchange system"

SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="
	dev-libs/gmp
	dev-perl/Math-BigInt-GMP
	>=virtual/perl-Math-BigInt-1.60
	dev-perl/crypt-random
"
DEPEND="${RDEPEND}"
