# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ebview/ebview-0.3.2.ebuild,v 1.2 2004/01/01 20:19:16 usata Exp $

IUSE=""

DESCRIPTION="EBView -- Electronic Book Viewer based on GTK+"
HOMEPAGE="http://ebview.sourceforge.net/"
SRC_URI="mirror://sourceforge/ebview/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-libs/eb-3.3.4
	>=x11-libs/gtk+-2.2
	sys-devel/gettext"

S=${WORKDIR}/${P}

src_unpack() {

	unpack ${A}

	if use nls && has_version '>=sys-devel/gettext-0.12' ; then
		cd ${S}/po
		epatch ${FILESDIR}/${PN}-gettext-0.12-gentoo.diff
	fi
}

src_compile() {

	export CPPFLAGS="${CPPFLAGS} -DPROTOTYPES"

	econf --with-eb-conf=/etc/eb.conf || die
	emake || die
}

src_install () {

	einstall || die

	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL* NEWS README TODO
}
