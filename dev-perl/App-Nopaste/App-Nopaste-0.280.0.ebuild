# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/App-Nopaste/App-Nopaste-0.280.0.ebuild,v 1.1 2011/03/23 08:13:47 tove Exp $

EAPI=3

MODULE_AUTHOR=SARTAK
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="Easy access to any pastebin"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pastebin clipboard github"

DEPEND="
	dev-perl/WWW-Mechanize
	virtual/perl-Module-Pluggable
	>=dev-perl/Moose-0.74
	>=dev-perl/MooseX-Getopt-0.17
	pastebin? (
		dev-perl/WWW-Pastebin-PastebinCom-Create
	)
	clipboard? (
		dev-perl/Clipboard
	)
	github? (
		dev-vcs/git[perl]
	)
"
#	github? (
#		|| (
#			dev-vcs/git[perl]
#			dev-perl/Config-GitLike
#		)
#	)
RDEPEND="${DEPEND}"
SRC_TEST="do"
