# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gnuconfig/gnuconfig-20070118.ebuild,v 1.1 2007/02/08 03:51:09 vapier Exp $

inherit eutils

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="http://savannah.gnu.org/projects/config"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/*.patch
}

src_compile() { :;}

src_install() {
	insinto /usr/share/${PN}
	doins config.{sub,guess} || die
	fperms +x /usr/share/${PN}/config.{sub,guess}
	dodoc ChangeLog
}
