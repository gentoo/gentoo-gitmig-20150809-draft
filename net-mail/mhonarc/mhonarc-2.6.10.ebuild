# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc/mhonarc-2.6.10.ebuild,v 1.3 2005/07/09 22:59:48 swegener Exp $

inherit perl-module

IUSE=""

SRC_URI="http://www.mhonarc.org/release/MHonArc/tar/MHonArc-${PV}.tar.bz2"
RESTRICT="nomirror"

DESCRIPTION="Perl Mail-to-HTML Converter"
HOMEPAGE="http://www.mhonarc.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha mips ~amd64"

S="${WORKDIR}/${P/mhonarc/MHonArc}"

src_install() {
	mv ${S}/Makefile ${S}/Makefile.orig
	sed -e "s:/usr:${D}/usr:g" -e "s:${D}/usr/bin/perl:/usr/bin/perl:g" \
		${S}/Makefile.orig > ${S}/Makefile
	perl-module_src_install
}
