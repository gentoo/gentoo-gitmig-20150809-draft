# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tinyca/tinyca-0.6.7.ebuild,v 1.1 2005/02/02 10:07:11 dragonheart Exp $


DESCRIPTION="Simple Perl/Tk GUI to manage a small certification authority"
HOMEPAGE="http://tinyca.sm-zone.net/"
SRC_URI="http://tinyca.sm-zone.net/${P}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

RDEPEND=">=dev-libs/openssl-0.9.7d
	dev-perl/Locale-gettext
	>=dev-perl/MIME-Base64-2.12
	dev-perl/gtk-perl
	>=dev-perl/perl-tk-800.024"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"


pkg_setup() {
	if [ ! -r /usr/lib/perl?/vendor_perl/*/*/Gnome.pm ]; then
		die "dev-perl/gtk-perl needs to be emerged with the gnome USE flag"
	fi
}


src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:./lib:/usr/share/tinyca/lib:g' \
		-e 's:./templates:/usr/share/tinyca/templates:g' \
		-e 's:./locale:/usr/share/locale:g' tinyca
}

src_compile() {
	make -C po
}

src_install() {
	dodir /usr/bin
	exeinto /usr/share/tinyca/
	doexe tinyca
	dosym /usr/share/tinyca/tinyca /usr/bin/tinyca
	insinto /usr/share/tinyca/lib
	doins lib/*.pm
	insinto /usr/share/tinyca/lib/GUI
	doins lib/GUI/*.pm
	insinto /usr/share/tinyca/templates
	doins templates/*
	insinto /usr/share/
	for LANG in de es cs; do
		dodir /usr/share/locale/${LANG}/LC_MESSAGES/
		insinto /usr/share/locale/${LANG}/LC_MESSAGES/
		doins locale/$LANG/LC_MESSAGES/tinyca.mo
	done

}
