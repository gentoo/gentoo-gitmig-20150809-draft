# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Wav/Audio-Wav-0.12.ebuild,v 1.1 2010/05/31 08:26:35 tove Exp $

EAPI=3

MODULE_AUTHOR=BRIANSKI
inherit perl-module

DESCRIPTION="Modules for reading & writing Microsoft WAV files."

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Inline"
DEPEND="${RDEPEND}"

SRC_TEST="do"
