# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-fr/man-pages-fr-1.64.0.ebuild,v 1.1 2005/09/02 04:28:51 vapier Exp $

MY_P=${P/-pages/}
DESCRIPTION="A somewhat comprehensive collection of french Linux man pages"
HOMEPAGE="http://fr.tldp.org/manfr.php"
SRC_URI="ftp://ftp.win.tue.nl/pub/linux-local/manpages/translations/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/man"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Don't trample on lilo's files, closes bug #91314
	rm man8/lilo.8 man5/lilo.conf.5
}

src_compile() { :; }

src_install() {
	dodoc LISEZ_MOI changements
	for x in man? ; do
		insinto /usr/share/man/fr/${x}
		doins ${x}/* || die "doins ${x}"
	done
}
