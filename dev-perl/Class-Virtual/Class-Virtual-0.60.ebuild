# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Virtual/Class-Virtual-0.60.ebuild,v 1.1 2011/02/08 09:25:37 tove Exp $

EAPI=3

MODULE_VERSION=0.06
MODULE_AUTHOR=MSCHWERN
inherit perl-module

DESCRIPTION="Base class for virtual base classes."

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86 ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Class-Data-Inheritable
	dev-perl/Carp-Assert
	perl-core/Class-ISA"
DEPEND="${RDEPEND}"

SRC_TEST="do"
