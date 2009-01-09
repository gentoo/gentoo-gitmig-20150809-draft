# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-fu/gtk2-fu-0.10.ebuild,v 1.12 2009/01/09 18:21:49 tove Exp $

MODULE_AUTHOR=DAMS
MY_PN=Gtk2Fu
MY_P=${MY_PN}-${PV}
inherit perl-module

DESCRIPTION="gtk2-fu is a layer on top of perl gtk2, that brings power, simplicity and speed of development"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-perl/gtk2-perl
	dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

S=${WORKDIR}/${MY_P}
SRC_TEST="do"
