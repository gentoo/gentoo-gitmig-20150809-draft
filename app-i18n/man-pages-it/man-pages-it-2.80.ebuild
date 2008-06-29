# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-it/man-pages-it-2.80.ebuild,v 1.1 2008/06/29 02:11:54 darkside Exp $

DESCRIPTION="A somewhat comprehensive collection of Italian Linux man pages"
HOMEPAGE="http://it.tldp.org/man/"
SRC_URI="ftp://ftp.pluto.it/pub/pluto/ildp/man/${P}.tar.gz"

LICENSE="LDP-1a"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/man"

src_compile() { :; }

src_install() {
	doman -i18n=it man*/*

	dodoc description readme CHANGELOG HOWTOHELP POSIX-COPYRIGHT \
		|| die "dodoc failed"
}
