# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rexml/rexml-2.4.0.ebuild,v 1.2 2002/07/10 17:00:09 rphillips Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Ruby Electric XML"
SRC_URI="http://www.germane-software.com/archives/${PN}_${PV}.tgz"
HOMEPAGE="http://www.germane-software.com/software/rexml/"
DEPEND=">=dev-lang/ruby-1.6.0"
LICENSE="Ruby"
KEYWORDS="x86"
SLOT="0"

src_unpack () {
	unpack ${A}
	cd ${S}/bin
	patch < ${FILESDIR}/${P}-gentoo.diff || die
}

src_install () {
	PORTAGETMP=${D} ruby bin/install.rb
}
