# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-FLAC-Header/Audio-FLAC-Header-2.2.ebuild,v 1.1 2008/09/07 06:06:00 tove Exp $

MODULE_AUTHOR=DANIEL
inherit perl-module

DESCRIPTION="Access to FLAC audio metadata"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="media-libs/flac
	dev-lang/perl"

SRC_TEST="do"
