# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/unclutter/unclutter-8-r1.ebuild,v 1.1 2006/01/11 06:53:17 robbat2 Exp $

inherit toolchain-funcs

S="${WORKDIR}/${PN}"
DESCRIPTION="Hides mouse pointer while not in use."
HOMEPAGE="http://www.ibiblio.org/pub/X11/contrib/utilities/unclutter-8.README"
SRC_URI="ftp://ftp.x.org/contrib/utilities/${P}.tar.Z"
SLOT="0"
LICENSE="public-domain"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="|| ( x11-libs/libX11 
			  virtual/x11
			)"
DEPEND="|| ( ( x11-libs/libX11 
			   x11-proto/xproto )
			 virtual/x11
			)"

src_compile() {
	# This xmkmf appears unnecessary
	# xmkmf -a || die "Couldn't run xmkmf"
	emake -j1 CDEBUGFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die
}

src_install () {
	dobin unclutter
	newman unclutter.man unclutter.1x
	dodoc README
}
