# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tinyca/tinyca-0.5.4-r1.ebuild,v 1.4 2006/02/11 21:09:01 mcummings Exp $

DESCRIPTION="Simple Perl/Tk GUI to manage a small certification authority"
HOMEPAGE="http://tinyca.sm-zone.net/"
SRC_URI="http://tinyca.sm-zone.net/${P}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6i
	dev-perl/Locale-gettext
	>=virtual/perl-MIME-Base64-2.12
	dev-perl/gtk-perl
	>=dev-perl/perl-tk-800.024"

S=${WORKDIR}/TinyCA

pkg_setup() {
	if [ ! -r /usr/lib/perl?/vendor_perl/*/*/Gnome.pm ]; then
		die "dev-perl/gtk-perl needs to be emerged with the gnome USE flag"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	# this app was written to be run from cwd and not meant to be installed
	# this little hack fixes that... pretty silly if you ask me
	sed -i \
		-e "s:\./lib:/usr/share/tinyca/lib:" \
		-e "s:\./template:/usr/share/tinyca/template:" \
		tinyca
}

src_install() {
	dodir /usr/bin
	exeinto /usr/share/tinyca/
	doexe tinyca
	dosym /usr/share/tinyca/tinyca /usr/bin/tinyca
	insinto /usr/share/tinyca/lib
	doins lib/*
	insinto /usr/share/tinyca/templates
	doins templates/*
}
