# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/localizer/localizer-1.0.0.ebuild,v 1.1 2003/02/18 23:54:29 kutsuya Exp $

inherit zproduct

DESCRIPTION="Helps to build multilingual zope websites and zope products."
HOMEPAGE="http://www.localizer.org"
SRC_URI="http://unc.dl.sourceforge.net/lleu/Localizer-${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86"

ZPROD_LIST="Localizer"

src_install()
{
	# Have to save a couple files from zproduct.eclass from putting them 
    # into the doc dir.
	cd Localizer
	mv languages.txt languages.dat
	mv charsets.txt charsets.dat
	cd ..
	zproduct_src_install do_zpfolders
	zproduct_src_install do_docs
	cd Localizer
	mv languages.dat languages.txt
	mv charsets.dat charsets.txt
    cd ..
	zproduct_src_install do_install
}