# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gwhere/gwhere-0.2.1-r1.ebuild,v 1.2 2006/02/25 18:19:02 smithj Exp $

inherit eutils

DESCRIPTION="Removable media cataloger made with GTK+"
HOMEPAGE="http://www.gwhere.org/"
SRC_URI="http://www.gwhere.org/download/source/${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="nls"

DEPEND="=x11-libs/gtk+-2*
		nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	if [ "${ARCH}" = "amd64" ]; then
		epatch ${FILESDIR}/${P}-amd64.patch
	fi
}

src_compile() {
	econf $(use_enable nls) --enable-gtk20 || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	# einstall is needed here
	einstall || die "einstall failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO || die "dodoc failed"
}
