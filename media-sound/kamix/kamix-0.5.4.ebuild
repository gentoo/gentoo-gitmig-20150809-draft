# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kamix/kamix-0.5.4.ebuild,v 1.3 2004/09/14 07:55:03 eradicator Exp $

inherit kde
need-kde 3

DESCRIPTION="A mixer for KDE and ALSA."
HOMEPAGE="http://kamix.sourceforge.net/"
SRC_URI="mirror://sourceforge/kamix/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND="${DEPEND}
	>=media-libs/alsa-lib-0.9"

S=${WORKDIR}/${PN}
