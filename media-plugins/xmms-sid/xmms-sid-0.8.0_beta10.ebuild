# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sid/xmms-sid-0.8.0_beta10.ebuild,v 1.8 2005/04/07 14:36:36 luckyduck Exp $

MY_PV=${PV/_beta/beta}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="C64 SID plugin for XMMS"
HOMEPAGE="http://www.tnsp.org/xmms-sid.php"
SRC_URI="http://tnsp.org/xs-files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""

# This really NEEDs one of the libsidplays, but unfortunately we need to RDEPEND on both for
# GRP to work right.
RDEPEND="media-sound/xmms
	=media-libs/libsidplay-1*
	=media-libs/libsidplay-2*"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7"

src_unpack() {
	unpack ${A}

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5

	cd ${S}
	aclocal -I . || die
	automake --foreign -v || die
	autoconf || die
	libtoolize --copy --force
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL README* NEWS TODO
}
