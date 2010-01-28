# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Mixer/Audio-Mixer-0.7.ebuild,v 1.10 2010/01/28 19:35:47 tove Exp $

MODULE_AUTHOR=SERGEY
inherit perl-module

DESCRIPTION="Perl extension for Sound Mixer control"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

# Dont' enable tests unless your working without a sandbox - expects to write to /dev/mixer
#SRC_TEST="do"
DEPEND="dev-lang/perl"
