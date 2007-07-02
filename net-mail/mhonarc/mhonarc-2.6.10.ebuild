# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc/mhonarc-2.6.10.ebuild,v 1.6 2007/07/02 14:56:07 peper Exp $

inherit perl-app

IUSE=""

SRC_URI="http://www.mhonarc.org/release/MHonArc/tar/MHonArc-${PV}.tar.bz2"
RESTRICT="mirror"

DESCRIPTION="Perl Mail-to-HTML Converter"
HOMEPAGE="http://www.mhonarc.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha ~amd64 mips ~ppc sparc x86"

S="${WORKDIR}/${P/mhonarc/MHonArc}"

src_install() {
	mv ${S}/Makefile ${S}/Makefile.orig
	sed -e "s:/usr:${D}/usr:g" -e "s:${D}/usr/bin/perl:/usr/bin/perl:g" \
		${S}/Makefile.orig > ${S}/Makefile
	perl-module_src_install
}
