# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Thread-Queue/Thread-Queue-3.10.0.ebuild,v 1.1 2012/11/17 19:42:01 tove Exp $

EAPI=4

MODULE_AUTHOR=JDHEDDEN
MODULE_VERSION=3.01
inherit perl-module

DESCRIPTION="Thread-safe queues"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-lang/perl[ithreads]
	>=virtual/perl-threads-shared-1.21
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Thread-Semaphore
	)"

SRC_TEST=do
