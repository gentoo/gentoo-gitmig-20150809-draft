# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Thread-Semaphore/Thread-Semaphore-2.09.ebuild,v 1.1 2010/02/15 19:48:01 tove Exp $

EAPI=2

MODULE_AUTHOR=JDHEDDEN
inherit perl-module

DESCRIPTION="Thread-safe semaphores"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-threads-shared
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST=do
