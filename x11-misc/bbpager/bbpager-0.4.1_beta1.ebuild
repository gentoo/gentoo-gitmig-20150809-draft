# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbpager/bbpager-0.4.1_beta1.ebuild,v 1.7 2006/12/07 02:29:24 flameeyes Exp $

MY_P=${P/_beta/beta}

DESCRIPTION="An understated pager for Blackbox."
HOMEPAGE="http://bbtools.sourceforge.net/"
SRC_URI="mirror://sourceforge/bbtools/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-wm/blackbox"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChanegLog README TODO
}
