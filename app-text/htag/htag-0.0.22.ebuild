# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/htag/htag-0.0.22.ebuild,v 1.1 2002/08/16 10:48:49 cybersystem Exp $

S="${WORKDIR}/htag-${PV}"

DESCRIPTION="HTag is a random signature maker for linux"
HOMEPAGE="http://www.earth.li/projectpurple/progs/htag.html"
SRC_URI="http://www.earth.li/projectpurple/files/htag-${PV}.tar.gz"
SLOT="0"
KEYWORDS="x86"

RDEPEND="sys-devel/perl"
LICENSE="GPL-2"

src_install () {
	mkdir -p $D/usr/{bin,lib/perl5/site_perl,share/htag/plugins,share/doc/htag-${PV},man/man1} || die
	install -o root -g root -m 755 htag.pl $D/usr/bin/htag || die
	cp -a docs/* $D/usr/share/doc/htag-${PV}/  || die
	find $D/usr/share/doc -type f ! -path '$D/usr/share/doc/htag-${PV}/sample-config/' | xargs gzip || die
	cp -a plugins/* $D/usr/share/htag/plugins/ || die
	install -o root -g root -m 644 HtagPlugin/HtagPlugin.pm $D/usr/lib/perl5/site_perl || die
}
