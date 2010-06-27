# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Wav/Audio-Wav-0.11.ebuild,v 1.5 2010/06/27 18:59:29 nixnut Exp $

EAPI=2

MODULE_AUTHOR=BRIANSKI
inherit perl-module

DESCRIPTION="Modules for reading & writing Microsoft WAV files."

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/Inline"
DEPEND="${RDEPEND}"

SRC_TEST="do"
