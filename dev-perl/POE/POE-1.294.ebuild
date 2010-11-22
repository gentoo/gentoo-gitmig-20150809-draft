# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE/POE-1.294.ebuild,v 1.1 2010/11/22 16:07:42 tove Exp $

EAPI=3

inherit versionator
MODULE_AUTHOR=RCAPUTO
MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="A framework for creating multitasking programs in Perl"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ipv6 libwww ncurses tk test"

RDEPEND=">=dev-perl/Event-1.09
	>=virtual/perl-File-Spec-0.87
	>=virtual/perl-IO-1.23.01
	>=virtual/perl-IO-Compress-1.33
	>=virtual/perl-Storable-2.12
	>=dev-perl/IO-Tty-1.08
	virtual/perl-Filter
	dev-perl/FreezeThaw
	dev-perl/yaml
	>=dev-perl/TermReadKey-2.21
	>=virtual/perl-Time-HiRes-1.59
	ipv6? ( >=dev-perl/Socket6-0.14 )
	tk? ( >=dev-perl/perl-tk-800.027 )
	libwww? ( >=dev-perl/libwww-perl-5.79
		>=dev-perl/URI-1.30 )
	ncurses? ( >=dev-perl/Curses-1.08 )"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/POE-Test-Loops-1.036
		>=virtual/perl-Test-Harness-2.26
		>=virtual/perl-Test-Simple-0.54
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
