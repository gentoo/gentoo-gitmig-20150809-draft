# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-SamTools/Bio-SamTools-1.290.0.ebuild,v 1.1 2011/09/01 13:02:36 tove Exp $

EAPI=4

MODULE_AUTHOR=LDS
MODULE_VERSION=1.29
inherit perl-module

DESCRIPTION="Read SAM/BAM database files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sci-biology/bioperl
	sci-biology/samtools"
RDEPEND="${DEPEND}
	virtual/perl-ExtUtils-CBuilder
	virtual/perl-Module-Build
"

SRC_TEST=do

src_prepare() {
	sed -i -e 's|my $HeaderFile = "bam.h";|my $HeaderFile = "bam/bam.h";|' \
		-e 's|my $LibFile    = "libbam.a";|my $LibFile    = "libbam.so";|' Build.PL || die
	sed -i -e 's|#include "bam.h"|#include "bam/bam.h"|' \
		-e 's|#include "khash.h"|#include "bam/khash.h"|' \
		-e 's|#include "faidx.h"|#include "bam/faidx.h"|' lib/Bio/DB/Sam.xs || die
	perl-module_src_prepare
}
