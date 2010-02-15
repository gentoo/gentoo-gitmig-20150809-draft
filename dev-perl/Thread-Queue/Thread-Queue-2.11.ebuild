# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Thread-Queue/Thread-Queue-2.11.ebuild,v 1.1 2010/02/15 19:50:11 tove Exp $

EAPI=2

MODULE_AUTHOR=JDHEDDEN
inherit perl-module

DESCRIPTION="Thread-safe queues"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-lang/perl[ithreads]
	>=virtual/perl-threads-shared-1.21
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	test? ( dev-perl/Thread-Semaphore
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
