# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kexchange/kexchange-1.0.ebuild,v 1.2 2005/03/10 14:50:11 greg_g Exp $

inherit kde

DESCRIPTION="A currency converter for KDE"
HOMEPAGE="http://www.favorin.com/projects/kexchange/"
SRC_URI="mirror://sourceforge/kexchange/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"
IUSE=""

need-kde 3
