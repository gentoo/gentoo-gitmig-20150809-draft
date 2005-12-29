# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc/mhonarc-2.6.15.ebuild,v 1.1 2005/12/29 18:37:49 stuart Exp $

inherit perl-app

IUSE=""

SRC_URI="http://www.mhonarc.org/release/MHonArc/tar/MHonArc-${PV}.tar.bz2"
RESTRICT="nomirror"

DESCRIPTION="Perl Mail-to-HTML Converter"
HOMEPAGE="http://www.mhonarc.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~amd64"

S="${WORKDIR}/${P/mhonarc/MHonArc}"

src_install() {
	sed -e "s|\$(INSTALLPRG)|\$(INSTALLPRG) -prefix ${D}|g" -i Makefile
	perl-module_src_install
}
