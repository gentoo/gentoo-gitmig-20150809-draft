# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htag/htag-0.0.22.ebuild,v 1.11 2007/08/24 06:25:45 wrobel Exp $

DESCRIPTION="random signature maker"
HOMEPAGE="http://www.earth.li/projectpurple/progs/htag.html"
SRC_URI="http://www.earth.li/projectpurple/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ~amd64 ~sparc ~mips"
IUSE=""
LICENSE="GPL-2"

RDEPEND="dev-lang/perl"

src_install() {
	newbin htag.pl htag || die

	dodir /usr/share/doc/${PF}/
	mv docs/sample-config ${D}/usr/share/doc/${PF}/
	dodoc docs/*
	prepalldocs

	insinto /usr/share/htag/plugins
	doins plugins/* || die

	insinto /usr/lib/perl5/site_perl
	doins HtagPlugin/HtagPlugin.pm || die
}
