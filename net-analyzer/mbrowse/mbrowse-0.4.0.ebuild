# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mbrowse/mbrowse-0.4.0.ebuild,v 1.1 2010/08/21 17:04:32 jer Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="MBrowse is a graphical MIB browser"
HOMEPAGE="http://sourceforge.net/projects/mbrowse/"
SRC_URI="mirror://sourceforge/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="net-analyzer/net-snmp
	=x11-libs/gtk+-2*"

src_prepare() {
	sed -i acinclude.m4 \
		-e '/LDFLAGS=/d' || die "sed failed"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS README ChangeLog
}
