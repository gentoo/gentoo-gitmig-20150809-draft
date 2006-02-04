# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/klamav/klamav-0.35.ebuild,v 1.1 2006/02/04 10:51:54 centic Exp $

inherit kde eutils flag-o-matic

MY_P="${P}-source"
S="${WORKDIR}/${MY_P}/${P}"

DESCRIPTION="KDE frontend for the ClamAV antivirus."
HOMEPAGE="http://klamav.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-antivirus/clamav"

need-kde 3

#src_unpack() {
#	kde_src_unpack
#
#	rm -f ${S}/configure
#}

#src_compile() {
#	PREFIX="${KDEDIR}"
#
#	kde_src_compile
#}

#src_install() {
#	kde_src_install
#
#}

