# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Thread-Semaphore/Thread-Semaphore-2.120.ebuild,v 1.1 2011/03/11 08:24:52 tove Exp $

EAPI=3

MODULE_AUTHOR=JDHEDDEN
MODULE_VERSION=2.12
inherit perl-module

DESCRIPTION="Thread-safe semaphores"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-threads-shared
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST=do
