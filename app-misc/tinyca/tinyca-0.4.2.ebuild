# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S="${WORKDIR}/TinyCA"
DESCRIPTION="Simple Perl/Tk GUI to manage a small certification authority"
SRC_URI="http://tinyca.sm-zone.net/${P}.tar.bz2"
HOMEPAGE="http://tinyca.sm-zone.net"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

DEPEND=">=dev-libs/openssl-0.9.6b
	>=dev-perl/MIME-Base64-2.12
	>=dev-perl/perl-tk-800.024"


src_unpack() {
	unpack ${A}
	cd ${S}
	# this app was written to be run from cwd and not meant to be installed
	# this little hack fixes that... pretty silly if you ask me
	cat tinyca | sed -e "s:\./lib:/usr/share/tinyca/lib:" \
	-e "s:\./template:/usr/share/tinyca/template:" > tinyca
}


src_install () {
	dodir /usr/bin
	exeinto /usr/share/tinyca/
	doexe tinyca
	dosym /usr/share/tinyca/tinyca /usr/bin/tinyca
	insinto /usr/share/tinyca/lib
	doins lib/*
	insinto /usr/share/tinyca/templates
	doins templates/*
}
