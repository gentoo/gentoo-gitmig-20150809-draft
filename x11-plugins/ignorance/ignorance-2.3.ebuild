# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/ignorance/ignorance-2.3.ebuild,v 1.2 2005/11/09 12:10:36 gothgirl Exp $

inherit eutils

DESCRIPTION="GAIM Advanced Ignore filter"
HOMEPAGE="http://ignorance.sf.net"
SRC_URI="mirror://sourceforge/ignorance/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=net-im/gaim-1.0.1"

src_unpack() {
	unpack ${A}
	# Set correct plugindir
	sed -i -e "s:^\(plugindir = \$(prefix)/\)lib/:\1$(get_libdir)/:" \
		${S}/Makefile.in || die "sed failed"
}
src_install() {
	emake install DESTDIR=${D} || die "Install failed"
	dodoc ChangeLog INSTALL README AUTHORS
}
