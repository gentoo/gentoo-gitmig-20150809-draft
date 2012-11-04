# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Message/HTTP-Message-6.60.0.ebuild,v 1.1 2012/11/04 15:00:37 tove Exp $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.06
inherit perl-module

DESCRIPTION="Base class for Request/Response"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	virtual/perl-Compress-Raw-Zlib
	>=dev-perl/URI-1.10
	>=virtual/perl-Encode-2.210.0
	>=dev-perl/HTTP-Date-6.0.0
	dev-perl/IO-HTML
	>=dev-perl/Encode-Locale-1.0.0
	>=dev-perl/LWP-MediaTypes-6.0.0
	>=virtual/perl-IO-Compress-2.021
	>=virtual/perl-MIME-Base64-2.1
"
DEPEND="${RDEPEND}"

SRC_TEST=online
