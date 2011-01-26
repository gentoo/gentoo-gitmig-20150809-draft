# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystemlog/ksystemlog-4.6.0.ebuild,v 1.1 2011/01/26 20:28:49 alexxy Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdeadmin"

inherit virtualx kde4-meta

DESCRIPTION="KDE system log viewer"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug test"

src_prepare() {
	kde4-meta_src_prepare

	if use test; then
		# beat this stupid test into shape: the test files contain no year, so
		# comparison succeeds only in 2007 !!!
		local theyear=$(date +%Y)
		sed -e "s:2007:${theyear}:g" -i ksystemlog/tests/systemAnalyzerTest.cpp
	fi
}

src_test() {
	export maketype="kde4-meta_src_test"
	virtualmake
}
