# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bitscope/bitscope-1.1.ebuild,v 1.3 2004/09/02 13:42:39 dholm Exp $

DESCRIPTION="A diagnosis tool for JACK audio software"
HOMEPAGE="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/"
SRC_URI="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/${P}.tar.gz"
RESTRICT=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

#first two for WANT_AUTOMAKE/CONF
DEPEND=">=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.7.2
	virtual/libc
	virtual/jack
	>=x11-libs/gtk+-2.0.0"

src_install() {
	einstall || die "make install failed"
	dodoc INSTALL README
	dohtml doc/*png doc/index.html
}
