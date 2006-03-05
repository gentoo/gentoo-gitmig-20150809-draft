# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/perlbox-voice/perlbox-voice-0.09.ebuild,v 1.1 2006/03/05 22:01:09 mcummings Exp $

IUSE=""

DESCRIPTION="A voice enabled application to bring your desktop under your command."

HOMEPAGE="http://perlbox.org/"
SRC_URI="mirror://sourceforge/perlbox/${P}.noarch.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/perl
	>=dev-perl/perl-tk
	>=app-accessibility/sphinx2
	>=app-accessibility/festival
	>=app-accessibility/mbrola"


RDEPEND=""



src_install() {
	tar -C ${D} -xvf perlbox-voice.ss
	dodoc LICENSE README
}
