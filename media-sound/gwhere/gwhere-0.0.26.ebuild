# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gwhere/gwhere-0.0.26.ebuild,v 1.4 2002/12/15 10:44:20 bjb Exp $

MY_P="${P/gw/GW}"
S="${WORKDIR}/${MY_P}"
SRC_URI="http://www.gwhere.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.gwhere.org/"
DESCRIPTION="CD Cataloguer made with GTK+"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-1.2
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""
	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
