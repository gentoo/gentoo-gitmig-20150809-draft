# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gwhere/gwhere-0.0.26.ebuild,v 1.3 2003/06/29 23:17:15 aliz Exp $

MY_P="${P/gw/GW}"
S="${WORKDIR}/${MY_P}"
SRC_URI="http://www.gwhere.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.gwhere.org/"
DESCRIPTION="removable media cataloguer made with GTK+"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-1.2
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
