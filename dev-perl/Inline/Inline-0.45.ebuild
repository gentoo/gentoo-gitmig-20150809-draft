# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline/Inline-0.45.ebuild,v 1.2 2009/12/18 08:25:06 tove Exp $

EAPI=2

MODULE_AUTHOR=SISYPHUS
inherit perl-module eutils

DESCRIPTION="Write Perl subroutines in other languages"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/perl-Digest-MD5
	virtual/perl-File-Spec
	dev-perl/Parse-RecDescent"
DEPEND="${RDEPEND}"

SRC_TEST=do
PATCHES=( "${FILESDIR}"/gtk2-patch.diff )
