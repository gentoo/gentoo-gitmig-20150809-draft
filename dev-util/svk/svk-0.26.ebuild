# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/svk/svk-0.26.ebuild,v 1.1 2004/11/27 06:31:08 pclouds Exp $

inherit perl-module

MP=${P/svk/SVK}
DESCRIPTION="A decentralized version control system"
SRC_URI="http://www.cpan.org/authors/id/C/CL/CLKAO/${MP}.tar.gz"
HOMEPAGE="http://svk.elixus.org/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
SRC_TEST="do"
IUSE=""
S=${WORKDIR}/${MP}

DEPEND="${DEPEND}
	>=dev-perl/SVN-Simple-0.26
	>=dev-perl/SVN-Mirror-0.50
	>=dev-perl/PerlIO-via-dynamic-0.11
	>=dev-perl/PerlIO-via-symlink-0.02
	>=dev-perl/Data-Hierarchy-0.21
	>=dev-perl/File-Temp-0.14
	dev-perl/Algorithm-Annotate
	dev-perl/Algorithm-Diff
	dev-perl/yaml
	dev-perl/Regexp-Shellish
	dev-perl/Pod-Escapes
	dev-perl/Pod-Simple
	dev-perl/Clone
	dev-perl/Text-Diff
	dev-perl/IO-String
	dev-perl/IO-Digest
	dev-perl/File-Type
	dev-perl/TimeDate
	dev-perl/URI
	dev-perl/PerlIO-eol
	>=dev-perl/Locale-Maketext-Lexicon-0.42
	>=dev-perl/Locale-Maketext-Simple-0.12
	dev-perl/Compress-Zlib
	dev-perl/FreezeThaw"
