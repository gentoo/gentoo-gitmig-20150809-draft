# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GnuPG-Interface/GnuPG-Interface-0.34.ebuild,v 1.12 2006/07/04 09:41:53 ian Exp $

inherit perl-module

DESCRIPTION=" GnuPG::Interface is a Perl module interface to interacting with GnuPG."
HOMEPAGE="http://gnupg-interface.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnupg-interface/${P}.tar.gz"
LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""
DEPEND=">=app-crypt/gnupg-1.2.1-r1
		>=dev-perl/Class-MethodMaker-1.11"
RDEPEND="${DEPEND}"

#SRC_TEST="do"