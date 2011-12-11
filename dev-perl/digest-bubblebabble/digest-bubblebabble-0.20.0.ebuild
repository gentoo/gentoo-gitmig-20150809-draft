# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/digest-bubblebabble/digest-bubblebabble-0.20.0.ebuild,v 1.2 2011/12/11 09:19:41 phajdan.jr Exp $

EAPI=3

MY_PN=Digest-BubbleBabble
MODULE_AUTHOR=BTROTT
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="Create bubble-babble fingerprints"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE=""

SRC_TEST=do
