# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Unidecode/Text-Unidecode-0.40.0.ebuild,v 1.9 2012/05/08 15:58:04 ranger Exp $

EAPI=4

MODULE_AUTHOR=SBURKE
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="US-ASCII transliterations of Unicode text"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST=do
