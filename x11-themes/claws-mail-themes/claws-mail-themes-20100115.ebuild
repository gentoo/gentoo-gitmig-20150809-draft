# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/claws-mail-themes/claws-mail-themes-20100115.ebuild,v 1.2 2010/04/08 10:45:46 fauli Exp $

DESCRIPTION="Iconsets for Claws Mail"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/themes/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5 as-is"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="mail-client/claws-mail"
DEPEND=""

src_install(){
	insinto /usr/share/claws-mail/themes
	doins -r *
}
