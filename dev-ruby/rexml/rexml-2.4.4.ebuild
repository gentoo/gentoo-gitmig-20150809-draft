# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rexml/rexml-2.4.4.ebuild,v 1.2 2003/02/13 11:42:15 vapier Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A pure Ruby XML parser with XPath support"
SRC_URI="http://www.germane-software.com/archives/${PN}_${PV}.tgz"
HOMEPAGE="http://www.germane-software.com/software/rexml/"
DEPEND=">=dev-lang/ruby-1.6.0"
LICENSE="Ruby"
KEYWORDS="~x86"
SLOT="0"

src_install () {
	ruby bin/install.rb -d ${D}
}
