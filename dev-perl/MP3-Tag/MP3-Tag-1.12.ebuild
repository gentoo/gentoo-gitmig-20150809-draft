# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Tag/MP3-Tag-1.12.ebuild,v 1.4 2010/05/08 18:02:23 armin76 Exp $

EAPI=2

MODULE_AUTHOR=ILYAZ
MODULE_SECTION=modules
inherit perl-module eutils

DESCRIPTION="Tag - Module for reading tags of mp3 files"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"
