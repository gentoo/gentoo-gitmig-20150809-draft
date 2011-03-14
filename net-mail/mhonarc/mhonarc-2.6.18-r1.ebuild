# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc/mhonarc-2.6.18-r1.ebuild,v 1.1 2011/03/14 08:31:12 iluxa Exp $

inherit perl-app

IUSE=""

SRC_URI="http://www.mhonarc.org/release/MHonArc/tar/MHonArc-${PV}.tar.bz2"
RESTRICT="mirror"

DESCRIPTION="Perl Mail-to-HTML Converter"
HOMEPAGE="http://www.mhonarc.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

S="${WORKDIR}/${P/mhonarc/MHonArc}"

src_install() {
	sed -e "s|-prefix |-docpath '${D}/usr/share/doc/${PF}' -prefix '${D}'|g" -i Makefile
	sed -e "s|installsitelib|installvendorlib|g" -i install.me
	perl-module_src_install
	prepalldocs
}
