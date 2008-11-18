# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-fu/gtk2-fu-0.10.ebuild,v 1.11 2008/11/18 15:47:13 tove Exp $
inherit perl-module

DESCRIPTION="gtk2-fu is a layer on top of perl gtk2, that brings power, simplicity and speed of development"
MY_P=Gtk2Fu-${PV}
S=${WORKDIR}/${MY_P}
SRC_URI="http://libconf.net/gtk2-fu/download/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dams/${MY_P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/gtk2-perl
	virtual/perl-Module-Build
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
