# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/dynamite/dynamite-0.1.1.ebuild,v 1.3 2011/02/10 14:59:55 ssuominen Exp $

DESCRIPTION="A tool (and library) for decompressing data compressed with PKWARE Data Compression Library"
HOMEPAGE="http://synce.sourceforge.net/synce/dynamite.php"
SRC_URI="mirror://sourceforge/synce/lib${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/lib${P}

src_install() {
	emake DESTDIR="${D}" install || die
}
